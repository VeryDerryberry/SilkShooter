extends CharacterBody2D

@export var speed = 600

var direction = Vector2.ZERO

func _ready():
	rotation = direction.angle()
	$CollisionShape2D.disabled = false
	connect("body_entered", _on_body_entered)
	
	
func _physics_process(delta):
	if direction != Vector2.ZERO:
		velocity = direction * speed
		move_and_slide()
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var body = collision.get_collider()
			if body and body.is_in_group("enemy"):
				body.queue_free()
				queue_free()
				return

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		body.queue_free()
		queue_free()
