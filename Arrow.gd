extends Area2D

export var speed = 50

func _process(delta):
	position -= Vector2(speed * delta, 0.0)
	
func _on_Arrow_body_entered(body):
	print("hit!")
	if !body.is_in_group("shooter"):
		queue_free()
