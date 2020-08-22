extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
export var opened = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$DoorClosed.show()
	$CollisionShape2D.set_deferred("enabled", true)
	opened = false

func open():
	$DoorClosed.hide()
	$CollisionShape2D.set_deferred("disabled", true)
	opened = true
	$DoorOpen.show()
	$AudioStreamPlayer.play()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
