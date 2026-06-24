extends Node2D

const MAIN_SCENE := preload("res://Main.tscn")

@onready var start_area: Area2D = $Area2D








var _starting := false


func _ready() -> void:
	start_area.mouse_entered.connect(_on_start_area_mouse_entered)
	start_area.mouse_exited.connect(_on_start_area_mouse_exited)


func _unhandled_input(event: InputEvent) -> void:
	if _starting:
		return
	if event.is_action_pressed("ui_accept"):
		
		_start_game()


func _on_area_2d_input_event(
	_viewport: Node,
	event: InputEvent,
	_shape_idx: int
) -> void:
	if _starting:
		return
	if event is InputEventMouseButton \
			and event.pressed \
			and event.button_index == MOUSE_BUTTON_LEFT:
		_start_game()


func _on_start_area_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_start_area_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _start_game() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	_starting = true
	get_tree().change_scene_to_packed(MAIN_SCENE)
