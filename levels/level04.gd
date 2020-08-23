extends "Level.gd"

func _ready():
	$Rat.connect("died", self, "_on_Rat_death")
	$Cheese.connect("body_entered", self, "_on_Cheese_body_entered")
	$Exit.connect("exited", self, "emit_signal", ["level_complete", true, "so smart!"])

func _on_Cheese_body_entered(body):
	$DoorExit.open()
	$Cheese.queue_free()
