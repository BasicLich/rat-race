extends Area2D

signal exited()

func _on_Exit_body_entered(body):
	emit_signal("exited")
