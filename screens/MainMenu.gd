extends Node2D

signal started()
signal exited()

const game = preload("res://stage.tscn")

func _on_newgame_pressed():
	var game_instance = game.instance()
	$Control.hide()
	add_child(game_instance)

func _on_exit_pressed():
	get_tree().quit()
