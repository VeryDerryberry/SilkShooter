extends CharacterBody2D

@export var speed: float = 320.0

var direction := Vector2.ZERO


func _ready() -> void:
	rotation = direction.angle()


func _physics_process(_delta: float) -> void:
	if direction == Vector2.ZERO:
		return

	velocity = direction * speed
	move_and_slide()

	for i in get_slide_collision_count():
		var collider = get_slide_collision(i).get_collider()
		if collider != null and collider.is_in_group("enemy"):
			_destroy_with(collider)
			return


func _destroy_with(enemy: Node) -> void:
	enemy.queue_free()
	queue_free()
