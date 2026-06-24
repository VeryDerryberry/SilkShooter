extends Node2D

const ENEMY_SCENE := preload("res://enemy.tscn")

@export var starting_enemies: int = 30
@export var spawn_half_extent: float = 475.0


func _ready() -> void:
	for _i in starting_enemies:
		_spawn_enemy()


func _spawn_enemy() -> void:
	var enemy := ENEMY_SCENE.instantiate()
	enemy.global_position = Vector2(
		randf_range(-spawn_half_extent, spawn_half_extent),
		randf_range(-spawn_half_extent, spawn_half_extent)
	)
	add_child(enemy)
	enemy.tree_exited.connect(_on_enemy_died, CONNECT_ONE_SHOT)

func _on_enemy_died() -> void:
	_spawn_enemy()
