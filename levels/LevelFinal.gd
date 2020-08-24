extends "Level.gd"

func _on_DialogueTrigger_fronk_speaks(message):
	emit_signal("fronk_speaks", message)
