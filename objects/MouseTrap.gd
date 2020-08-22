extends Node2D

func _on_MouseTrap_body_entered(body):
	$AudioStreamPlayer.play()
	body.kill("caught in a trap")
