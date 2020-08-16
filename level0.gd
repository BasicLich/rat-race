extends Node2D

#signal complete()

var hands = preload("res://Hands.tscn")



# Called when the node enters the scene tree for the first time.
func _ready():

	var button = get_node("FloorButton_0")
	
	button.connect("body_entered", self, "_on_button_pressed")
	
	$Rat.connect("died", self, "_on_rat_died")
	

func _on_button_pressed(body):
	if body.is_in_group("player"):
		var door = get_node("Door1").open()
		
func _on_rat_died():
	var camera = $Rat.get_node("Camera2D")
	var hand = hands.instance()
	hand.init($Rat)
	hand.position = $Rat.position - Vector2(get_viewport().size.x / 4, get_viewport().size.y / 4)
	hand.exit_position = hand.position
	hand.target = $Rat.position
	hand.connect("carry_complete", self, "_on_carry_complete")

	$Rat.remove_child(camera)
	$Rat.get_node("Hitbox").set_deferred("disabled", true)
	camera.position = $Rat.position
	add_child(camera)
	add_child(hand)
	
func _on_carry_complete():
	emit_signal("level_complete")
