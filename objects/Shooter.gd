extends StaticBody2D

var arrow = preload("res://objects/Arrow.tscn")
export var frequency = 1.0 

func _ready():
	$Timer.wait_time = frequency

func _on_shooting_timer_timeout():
	var arrow_instance = arrow.instance()
	arrow_instance.position = Vector2(-20, 5)
	add_child(arrow_instance)
