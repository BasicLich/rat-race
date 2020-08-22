extends Node2D

signal started()
signal exited()

const game = preload("res://stage.tscn")

func _on_newgame_pressed():
	var game_instance = game.instance()
	game_instance.connect("restart", self, "_on_restart")
	$Control.hide()
	add_child(game_instance)

func _on_exit_pressed():
	get_tree().quit()

func _on_restart(scene):
	call_deferred("remove_child", scene)
	scene.call_deferred("queue_free")
	$Control.show()
	$AudioStreamPlayer.play()
	_on_newgame_pressed()
