extends Area2D

signal fronk_speaks(message)

export var message: String

func _on_DialogueTrigger_body_entered(body):
	assert(message)
	emit_signal("fronk_speaks", message)
