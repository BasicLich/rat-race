extends Node2D

signal nexted(scene)

var rat_id: int

func _ready():
	$CanvasLayer/Name.text = "Welcome rat #" + str(rat_id) + ":"

func _on_menu_button_pressed():
	$PressSound.play()

func _on_menu_button_mouse_entered():
	$AudioStreamPlayer.play()

func _on_PressSound_finished():
	emit_signal("nexted", self)
