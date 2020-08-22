extends Area2D

func _ready():
	assert(get_node("Destination"))

func _on_Toilet_body_entered(body):
	$AudioStreamPlayer.play()
	body.global_position = get_node("Destination").global_position
