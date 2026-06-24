extends CharacterBody2D

const PROJECTILE_SCENE := preload("res://Projectile.tscn")
const ABDOMEN_SHEET := preload("res://player/abdomen_spritesheet.png")

const ABDOMEN_FRAME_COUNT := 9
const ABDOMEN_IDLE_FRAME := 8
const ABDOMEN_DEGREES_PER_FRAME := 22.5

@export var speed: float = 180.0
@export var abdomen_lerp_speed: float = 12.0

@onready var body: Sprite2D = $Body
@onready var abdomen: Sprite2D = $Body/Abdomen

var last_move_direction := Vector2.DOWN
var _abdomen_aim_deg: float = 180.0


func _ready() -> void:
	_setup_abdomen_spritesheet()
	body.rotation = last_move_direction.angle()
	_reset_abdomen()


func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed

	if direction != Vector2.ZERO:
		last_move_direction = direction
		body.rotation = last_move_direction.angle()

	move_and_slide()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
			and event.pressed \
			and event.button_index == MOUSE_BUTTON_LEFT:
		_shoot()


func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_abdomen_aim_deg = _aim_degrees_relative_to_body()
		_apply_abdomen_pose(_abdomen_aim_deg)
	else:
		var t := clampf(abdomen_lerp_speed * delta, 0.0, 1.0)
		_abdomen_aim_deg = rad_to_deg(
			lerp_angle(deg_to_rad(_abdomen_aim_deg), deg_to_rad(180.0), t)
		)
		_apply_abdomen_pose(_abdomen_aim_deg)


func _setup_abdomen_spritesheet() -> void:
	abdomen.texture = ABDOMEN_SHEET
	abdomen.hframes = 3
	abdomen.vframes = 3


func _reset_abdomen() -> void:
	_abdomen_aim_deg = 180.0
	_apply_abdomen_pose(_abdomen_aim_deg)


func _apply_abdomen_pose(aim_deg: float) -> void:
	# Godot angles increase clockwise; the sheet is drawn counter-clockwise (0° → up → 180°).
	var sheet_deg := -aim_deg
	abdomen.flip_v = sheet_deg < 0.0
	if abdomen.flip_v:
		sheet_deg = -sheet_deg

	var frame_index := clampi(
		int(roundf(sheet_deg / ABDOMEN_DEGREES_PER_FRAME)),
		0,
		ABDOMEN_FRAME_COUNT - 1
	)

	abdomen.frame = frame_index
	abdomen.flip_h = false
	abdomen.rotation = 0.0


func _aim_degrees_relative_to_body() -> float:
	var aim_direction := _mouse_aim_direction()
	if aim_direction.length_squared() == 0.0:
		return 0.0

	var mouse_angle := aim_direction.angle()
	return rad_to_deg(angle_difference(body.rotation, mouse_angle))


func _mouse_aim_direction() -> Vector2:
	return get_global_mouse_position() - global_position


func _shoot() -> void:
	var aim := _mouse_aim_direction()
	if aim.length_squared() == 0.0:
		aim = last_move_direction

	var projectile := PROJECTILE_SCENE.instantiate()
	projectile.global_position = global_position
	projectile.direction = aim.normalized()
	get_parent().add_child(projectile)
