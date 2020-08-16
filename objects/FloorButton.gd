extends Area2D

export var opened = false

func _ready():
	if opened: 
		open()
	else:
		close()

func open():
	$Closed.hide()
	$Opened.show()
	opened = true
	
func close():
	$Opened.hide()
	$Closed.show()
	opened = false

func _on_FloorButton_body_entered(body):
	# TODO: this is one-shot button, could be more sophisticated
	open()
