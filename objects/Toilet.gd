extends Area2D

export var destination: Vector2

func _on_Toilet_body_entered(body):
	if body.is_in_group("player"):
		body.position = destination
