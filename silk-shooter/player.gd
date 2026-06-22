extends CharacterBody2D

const PROJECTILE_SCENE := preload("res://Projectile.tscn")
const ABDOMEN_SHEET := preload("res://player/abdomen_spritesheet.png")

const ABDOMEN_FRAME_COUNT := 9
const ABDOMEN_IDLE_FRAME := 8
const ABDOMEN_DEGREES_PER_FRAME := 22.5

@export var speed: float = 180.0

@onready var body: Sprite2D = $Body
@onready var abdomen: Sprite2D = $Body/Abdomen

var last_move_direction := Vector2.DOWN


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


func _process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_aim_abdomen()
	else:
		_reset_abdomen()


func _setup_abdomen_spritesheet() -> void:
	abdomen.texture = ABDOMEN_SHEET
	abdomen.hframes = 3
	abdomen.vframes = 3


func _reset_abdomen() -> void:
	abdomen.frame = ABDOMEN_IDLE_FRAME
	abdomen.flip_h = false
	abdomen.flip_v = false
	abdomen.rotation = 0.0


func _aim_abdomen() -> void:
	# Godot angles increase clockwise; the sheet is drawn counter-clockwise (0° → up → 180°).
	var sheet_deg := -_aim_degrees_relative_to_body()
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