extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 150
var target = Vector2()
var exit_position
var rat
var has_rat = false

func init(node):
	rat = node

	
func _process(delta):
	var direction = (target - position).normalized()
	position += direction * speed * delta
	if target.distance_squared_to(position) < 1.0:
		rat.get_parent().remove_child(rat)
		add_child(rat)
		rat.position = Vector2()
		target = exit_position
		speed -= 50
	
