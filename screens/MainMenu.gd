extends Node2D

signal started()
signal exited()

const game = preload("res://stage.tscn")

func _on_newgame_pressed():
	var game_instance = game.instance()
	game_instance.connect("restart", self, "_on_restart")
	$Control.hide()
	$PressSound.play()
	add_child(game_instance)

func _on_exit_pressed():
	get_tree().quit()

func _on_restart(scene):
	call_deferred("remove_child", scene)
	scene.call_deferred("queue_free")
	$Control.show()
	$AudioStreamPlayer.play()
	_on_newgame_pressed()


# TODO: combine to one
func _on_newgame_mouse_entered():
	$ButtonSound.play()

func _on_exit_mouse_entered():
	$ButtonSound.play()
