extends "levels/Level.gd"

var hands = preload("res://Hands.tscn")

func _ready():

	var button = get_node("FloorButton_0")
	
	button.connect("body_entered", self, "_on_button_pressed")
	
	$DancePad.connect("completed", self, "_on_dance_pad_completed")
	
	$Rat.connect("died", self, "_on_rat_died")
	$Rat.connect("tick", self, "_on_tick")

func _on_button_pressed(body):
	if body.is_in_group("player"):
		var door = get_node("DoorExit").open()
		#$Cat.chase($Rat)
		
func _on_rat_died(reason):
	var camera = $Rat.get_node("Camera2D")
	var hand = hands.instance()
	hand.init($Rat)
	hand.position = $Rat.position - Vector2(get_viewport().size.x / 4, get_viewport().size.y / 4)
	hand.exit_position = hand.position
	hand.target = $Rat.position
	hand.reason = reason
	hand.connect("carry_complete", self, "_on_carry_complete")

	$Rat.remove_child(camera)
	$Rat.get_node("Hitbox").set_deferred("disabled", true)
	camera.position = $Rat.position
	add_child(camera)
	add_child(hand)
	
func _on_dance_pad_completed(successful):
	if successful:
		$DoorExit.open()
	else:
		$Rat.kill("danced to death")
	
func _on_carry_complete(reason):
	emit_signal("level_complete", false, reason)


func _on_Exit_exited():
	emit_signal("level_complete", true, "so smart!")
