extends Node2D

signal started()
signal exited()



func _on_newgame_pressed():
	emit_signal("started")
