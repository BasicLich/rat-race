extends Node

signal level_complete()
signal tick(time_left)

export var time_limit: int

var timer = Timer.new()
var time_left: int

func _ready():
	assert(time_limit > 0)
	add_child(timer)
	time_left = time_limit
	timer.connect("timeout", self, "_on_tick")
	emit_signal("tick", time_left)
	timer.start()

func _on_tick():
	time_left -= 1
	if (time_left < 0):
		timer.stop()
		get_node("Rat").kill()
	else:
		emit_signal("tick", time_left)
