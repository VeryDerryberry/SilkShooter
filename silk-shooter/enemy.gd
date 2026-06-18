extends CharacterBody2D

@export var speed = 100
var player: Node2D

func _ready():
		add_to_group("enemy")
		player = get_tree().get_first_node_in_group("Player")

func _physics_process(delta):

	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		rotation = direction.angle()
		move_and_slide()
