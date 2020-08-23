extends Node

signal level_complete(successful, reason)
signal tick(time_left)
signal fronk_speaks(message)

export var time_limit: int

var hands = preload("res://objects/Hands.tscn")
var timer = Timer.new()
var time_left: int

func _ready():
	assert(get_node("Exit"))
	assert(get_node("Rat"))
	assert(time_limit > 0)

	add_child(timer)
	time_left = time_limit
	timer.connect("timeout", self, "_on_tick")
	emit_signal("tick", time_left)
	timer.start()

func _on_Rat_death(reason):
	timer.stop()
	get_node("AudioStreamPlayer").stop()
	var camera = $Rat.get_node("Camera2D")
	print(camera)
	var hand = hands.instance()
	hand.init($Rat)
	hand.position = $Rat.position - Vector2(get_viewport().size.x / 4, get_viewport().size.y / 4)
	hand.exit_position = hand.position
	hand.target = $Rat.position
	hand.reason = reason
	hand.connect("carry_complete", self, "_on_carry_complete")

	$Rat.remove_child(camera)
	$Rat.get_node("Hitbox").set_deferred("disabled", true)
	camera.position = $Rat.position
	add_child(camera)
	add_child(hand)

func _on_carry_complete(reason):
	emit_signal("level_complete", false, reason)

func _on_tick():
	time_left -= 1
	if (time_left < 0):
		timer.stop()
		get_node("Rat").kill("not quick enough")
	else:
		emit_signal("tick", time_left)
