extends CharacterBody2D

@export var speed: float = 60.0

var _player: Node2D


func _ready() -> void:
	add_to_group("enemy")
	_player = get_tree().get_first_node_in_group("Player") as Node2D


func _physics_process(_delta: float) -> void:
	if _player == null:
		return

	var offset := _player.global_position - global_position
	if offset.length_squared() == 0.0:
		return

	var direction := offset.normalized()
	velocity = direction * speed
	rotation = direction.angle()
	move_and_slide()