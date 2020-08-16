extends Area2D

export var speed = 50

signal hit()

func _process(delta):
	position -= Vector2(speed * delta, 0.0)
	
func _on_Arrow_body_entered(body):
	if body.is_in_group("player"):
		body.kill()
	if !body.is_in_group("shooter"):
		queue_free()
