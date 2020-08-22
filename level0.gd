extends "levels/Level.gd"

func _ready():
	var button = get_node("FloorButton_0")
	button.connect("body_entered", self, "_on_button_pressed")
	$DancePad.connect("completed", self, "_on_dance_pad_completed")	
	$Rat.connect("died", self, "_on_Rat_death")
	$Rat.connect("tick", self, "_on_tick")

func _on_button_pressed(body):
	var door = get_node("DoorExit").open()
	
func _on_dance_pad_completed(successful):
	if successful:
		$DoorExit.open()
	else:
		$Rat.kill("danced to death")
	
func _on_Exit_exited():
	emit_signal("level_complete", true, "so smart!")
