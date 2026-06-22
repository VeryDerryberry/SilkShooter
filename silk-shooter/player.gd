extends CharacterBody2D

@export var speed = 300

@onready var body: Sprite2D = $Body
@onready var abdomen: Sprite2D = $Body/Abdomen

var last_move_direction: Vector2 = Vector2.DOWN  # Default initial facing (adjust as needed)

# Sprite sheet setup: 9 frames (0° index 0 to 180° index 8)
@onready var abdomen_sheet: Texture2D = load("res://player/abdomen_spritesheet.png")

func _ready() -> void:
	# Setup abdomen sprite sheet
	abdomen.texture = abdomen_sheet
	abdomen.hframes = 9
	abdomen.vframes = 1
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

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			shoot()

func _process(delta: float) -> void:
	# Update abdomen every frame for responsive aiming (while LMB held)
	var is_firing = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	update_abdomen(is_firing)

func update_abdomen(is_firing: bool) -> void:
	if abdomen == null:
		return
	if not is_firing:
		# Not firing: abdomen points 180° opposite to body direction (frame 8)
		abdomen.frame = 8
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

	# For angles > 180° (or negative side), use flip_h and map to 0-180 range from sprite sheet
	var use_flip = rel_deg < 0
	var target_abs = abs(rel_deg)

	# Pick closest discrete angle frame (0-8)
	var index = round(target_abs / 22.5)
	index = clamp(index, 0, 8)
	var picked_angle = index * 22.5

	# Apply the correct frame from sprite sheet
	abdomen.frame = index
	abdomen.flip_h = use_flip
	abdomen.rotation = 0.0  # Keep 0; frames are pre-oriented relative to body forward

func shoot() -> void:
	var projectile = load("res://Projectile.tscn").instantiate()
	projectile.global_position = global_position
	projectile.direction = (get_global_mouse_position() - global_position).normalized()
	get_parent().add_child(projectile)
