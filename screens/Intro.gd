extends Node2D

signal nexted(scene)

var rat_id: int

func _ready():
	$CanvasLayer/Name.text = "Welcome rat #" + str(rat_id) + ":"

func _on_menu_button_pressed():
	emit_signal("nexted", self)
