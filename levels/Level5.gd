extends Node2D

func _ready():
	$DancePad.connect("completed", self, "_on_dance_pad_completed")
	$DancePad2.connect("completed", self, "_on_dance_pad2_completed")
	
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
		
		
