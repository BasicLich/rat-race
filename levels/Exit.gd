extends Area2D

signal exited()

func _on_Exit_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("exited")
