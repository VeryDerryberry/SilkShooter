extends CharacterBody2D

@export var speed = 300

@onready var body: Sprite2D = $Body
@onready var abdomen: Sprite2D = $Body/Abdomen

var last_move_direction: Vector2 = Vector2.DOWN  # Default initial facing (adjust as needed)

# Abdomen angle textures (0° to 180° in 22.5° steps). Index 0 = 0°, Index 8 = 180°
var abdomen_angle_textures: Array[String] = [
	"res://player/RedArrow.png",      # 0° (forward relative?)
	"res://player/RedArrow22_5.png",  # 22.5°
	"res://player/RedArrow45.png",    # 45°
	"res://player/RedArrow67_5.png",  # 67.5°
	"res://player/RedArrow90.png",    # 90°
	"res://player/RedArrow112_5.png", # 112.5°
	"res://player/RedArrow135.png",   # 135°
	"res://player/RedArrow157_5.png", # 157.5°
	"res://player/RedArrow180.png"    # 180° (back, default when not firing)
]

func _ready() -> void:
	# Initial body facing
	body.rotation = last_move_direction.angle()
	# Start with abdomen pointing 180° back
	update_abdomen(false)

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	if direction != Vector2.ZERO:
		last_move_direction = direction
		body.rotation = last_move_direction.angle()
	move_and_slide()

func _process(delta: float) -> void:
	# Update abdomen every frame for responsive aiming
	var is_firing = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	update_abdomen(is_firing)

func update_abdomen(is_firing: bool) -> void:
	if abdomen == null:
		return
	if not is_firing:
		# Not firing: abdomen points 180° opposite to body direction
		# Uses the 180° sprite, no flip, local rotation 0 so pre-rotated art + body rot gives correct global back
		abdomen.texture = load(abdomen_angle_textures[8])
		abdomen.flip_h = false
		abdomen.rotation = 0.0
		return

	# Firing: aim abdomen toward mouse using body direction + mouse direction math
	# Calculate relative angle (mouse global - body global)
	var body_angle = body.rotation
	var mouse_angle = (get_global_mouse_position() - global_position).angle()
	var rel_rad = mouse_angle - body_angle
	# Normalize relative angle to range [-PI, PI] (~ -180° to 180°)
	rel_rad = fmod(rel_rad + PI, TAU) - PI
	var rel_deg = rad_to_deg(rel_rad)

	# For angles > 180° (or negative side), use flip_h and map to 0-180 range
	var use_flip = rel_deg < 0
	var target_abs = abs(rel_deg)

	# Pick closest discrete angle from sprite sheet (0, 22.5, ..., 180)
	var index = round(target_abs / 22.5)
	index = clamp(index, 0, 8)
	var picked_angle = index * 22.5

	# Apply the correct sprite from sheet (or individual textures for now)
	abdomen.texture = load(abdomen_angle_textures[index])
	abdomen.flip_h = use_flip
	abdomen.rotation = 0.0  # Keep 0; the texture art + relative body handles the swivel visually

func shoot() -> void:
	var projectile = load("res://Projectile.tscn").instantiate()
	projectile.global_position = global_position
	projectile.direction = (get_global_mouse_position() - global_position).normalized()
	get_parent().add_child(projectile)
