extends StaticBody2D

export var opened = false

func _ready():
	if opened:
		open()
	else:
		close()

func close():
	$Open.hide()
	$Closed.show()
	$CollisionShape2D.set_deferred("enabled", true)
	opened = false

func open():
	$Closed.hide()
	$Open.show()
	$CollisionShape2D.set_deferred("disabled", true)
	opened = true
	$OpenSound.play()
	
func _process(delta):
	var tick = float(OS.get_ticks_msec()) / 400.0
	var r = .5 * (1 + sin(tick))
	var g = .5 * (1 + cos(tick))
	var b = .5 * (1 + sin(tick + PI/2))

	$Open/Background.self_modulate = Color(r, g, b)
	
