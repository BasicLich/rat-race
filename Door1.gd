extends Node2D

export var opened = false

func _ready():
	if opened:
		open()
	else:
		close()

func open():
	$door_closed.hide()
	$door_closed.get_node("StaticBody2D").get_node("CollisionShape2D").set_deferred("disabled", true)
	opened = true
	$door_opened.show()

func close():
	var door_node = get_node("door_closed")
	door_node.show()
	door_node.get_node("StaticBody2D").get_node("CollisionShape2D").disabled = false
	opened = false
	$door_opened.hide()
	
