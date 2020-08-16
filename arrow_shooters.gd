extends StaticBody2D

var arrow = preload("res://Arrow.tscn")

func _ready():
	pass

func _on_shooting_timer_timeout():
	var arrow_instance = arrow.instance()
	arrow_instance.position = Vector2(-10, 5)

	add_child(arrow_instance)
