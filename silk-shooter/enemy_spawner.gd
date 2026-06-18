extends Node2D

var current_enemies = 0
@export var starting_enemies = 3

func _ready():
	for i in starting_enemies:
		spawn_enemy()

func spawn_enemy():
	var enemy = load("res://enemy.tscn").instantiate()
	enemy.global_position = Vector2(
		randf_range(-475, 475),
		randf_range(-475, 475)
	)
	add_child(enemy)
	current_enemies += 1
	enemy.tree_exited.connect(_on_enemy_died)

func _on_enemy_died():
	print("Enemies alive: ", get_tree().get_nodes_in_group("enemy").size())
	current_enemies -= 1
	spawn_enemy()     # Replace the one that died
	spawn_enemy()     # Add one extra
