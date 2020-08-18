extends Node2D

# enum State {IDLE, PLAYING, READING, COMPLETE}
enum Arrow {RIGHT, LEFT, UP, DOWN}

var sequence = [Arrow.UP, Arrow.DOWN, Arrow.LEFT, Arrow.RIGHT]

func begin():
	$MiddleButton/CollisionShape2D.set_deferred("disabled", true)
	$MiddleButton/Up.hide()
	$MiddleButton/Down.show()
	
	# turn on arrows
	$ArrowUp/CollisionShape2D.set_deferred("disabled", false)
	$ArrowDown/CollisionShape2D.set_deferred("disabled", false)

	play_sequence()

func play_sequence():
	var timer = Timer.new()
	timer.wait_time = 1
	timer.connect("timeout", self, "display", [sequence, timer])
	add_child(timer)
	timer.start()

func test():
	print("hello")

func display(sequence, timer):
	
	if sequence.empty():
		timer.stop()
		timer.queue_free()
	
	var direction = sequence.pop_front()
	
	$DisplayArrow/Up.hide()
	$DisplayArrow/Down.hide()
	$DisplayArrow/Left.hide()
	$DisplayArrow/Right.hide()
	
	if direction == Arrow.UP:
		$DisplayArrow/Up.show()
	elif direction == Arrow.DOWN:
		$DisplayArrow/Down.show()	
	elif direction == Arrow.LEFT:
		$DisplayArrow/Left.show()
	elif direction == Arrow.RIGHT:
		$DisplayArrow/Right.show()


func _on_MiddleButton_body_entered(body):
	if body.is_in_group("player"):
		begin()


func _on_ArrowUp_body_entered(body):
	$ArrowUp/On.show()
	
func _on_ArrowUp_body_exited(body):
	$ArrowUp/On.hide()



func _on_ArrowDown_body_entered(body):
	$ArrowDown/On.show()
	
	


func _on_ArrowDown_body_exited(body):
	$ArrowDown/On.hide()
