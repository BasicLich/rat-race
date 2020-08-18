extends Node2D

enum State {IDLE, PLAYING, READING, COMPLETE}
enum Arrow {RIGHT, LEFT, UP, DOWN}

var sequence = [
	Arrow.UP, 
	Arrow.DOWN, 
	Arrow.DOWN, 
	Arrow.UP, 
	Arrow.LEFT, 
	Arrow.LEFT, 
	Arrow.RIGHT
	]
	
var check = []

var state = State.IDLE

func begin():
	$MiddleButton/CollisionShape2D.set_deferred("disabled", true)
	$MiddleButton/Up.hide()
	$MiddleButton/Down.show()
	
	# turn on arrows
	$ArrowUp/CollisionShape2D.set_deferred("disabled", false)
	$ArrowDown/CollisionShape2D.set_deferred("disabled", false)
	$ArrowLeft/CollisionShape2D.set_deferred("disabled", false)
	$ArrowRight/CollisionShape2D.set_deferred("disabled", false)

	play_sequence()


func play_sequence():

	
	var clear_timer = Timer.new()
	clear_timer.wait_time = .5
	clear_timer.connect("timeout", self, "clear")
	add_child(clear_timer)
	clear_timer.start()
	
	var timer = Timer.new()
	timer.wait_time = 1
	timer.connect("timeout", self, "display", [sequence, timer, clear_timer])
	add_child(timer)
	timer.start()
	state = State.PLAYING

func clear():
	$DisplayArrow/Up.hide()
	$DisplayArrow/Down.hide()
	$DisplayArrow/Left.hide()
	$DisplayArrow/Right.hide()

func display(sequence, timer, clear_timer):
	
	if sequence.empty():
		timer.stop()
		timer.queue_free()
		clear_timer.stop()
		clear_timer.queue_free()
		state = State.READING
		return
	
	var direction = sequence.pop_front()
	
	if direction == Arrow.UP:
		$DisplayArrow/Up.show()
	elif direction == Arrow.DOWN:
		$DisplayArrow/Down.show()	
	elif direction == Arrow.LEFT:
		$DisplayArrow/Left.show()
	elif direction == Arrow.RIGHT:
		$DisplayArrow/Right.show()
		
	check.append(direction)

func failed():
	$display_error.show()
	
func succeed():
	state = State.COMPLETE
	$display_success.show()



func _on_MiddleButton_body_entered(body):
	if body.is_in_group("player"):
		begin()


func _on_ArrowUp_body_entered(body):
	$ArrowUp/On.show()
	if state == State.READING:
		if check.pop_front() != Arrow.UP:
			failed()
		elif check.empty():
			succeed()
		
	
func _on_ArrowUp_body_exited(body):
	$ArrowUp/On.hide()



func _on_ArrowDown_body_entered(body):
	$ArrowDown/On.show()
	if state == State.READING:
		if check.pop_front() != Arrow.DOWN:
			failed()
		elif check.empty():
			succeed()
	


func _on_ArrowDown_body_exited(body):
	$ArrowDown/On.hide()


func _on_ArrowRight_body_entered(body):
	$ArrowRight/On.show()
	if state == State.READING:
		if check.pop_front() != Arrow.RIGHT:
			failed()
		elif check.empty():
			succeed()


func _on_ArrowRight_body_exited(body):
	$ArrowRight/On.hide()


func _on_ArrowLeft_body_entered(body):
	$ArrowLeft/On.show()
	if state == State.READING:
		if check.pop_front() != Arrow.LEFT:
			failed()
		elif check.empty():
			succeed()


func _on_ArrowLeft_body_exited(body):
	$ArrowLeft/On.hide()
