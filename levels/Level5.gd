extends "Level.gd"



func _ready():
	$Rat.connect("died", self, "_on_Rat_death")
	$DancePad.connect("completed", self, "_on_dance_pad_completed")
	$DancePad2.connect("completed", self, "_on_dance_pad2_completed")
	$Cheese.connect("body_entered", self, "_on_Cheese_body_entered")
	$Exit.connect("exited", self, "_on_level_complete")
	
func _on_dance_pad_completed(successful):
	if successful:
		$Door1.open()
	else:
		$Rat.kill("danced to death")
		
func _on_dance_pad2_completed(successful):
	if successful:
		$Door2.open()
	else:
		$Rat.kill("danced to death")
		
func _on_level_complete():
	emit_signal("level_complete", true, "is satisfactory", time_left)

func _on_Cheese_body_entered(body):
	$DoorExit.open()
	$Cheese.queue_free()
