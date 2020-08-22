extends KinematicBody2D

export var speed = 150
var velocity = Vector2()

var alive = true
var play_sound = true

signal died()

func _input(event):
	if alive:
		if event.is_action_pressed("ui_left"):
			velocity.x = -1
			$AnimatedSprite.flip_h = true
		elif event.is_action_pressed("ui_right"):
			velocity.x = 1
			$AnimatedSprite.flip_h = false
		elif event.is_action_released("ui_left") and !Input.is_action_pressed("ui_right"):
			velocity.x = 0
		elif event.is_action_released("ui_right") and !Input.is_action_pressed("ui_left"):
			velocity.x = 0
			
		if event.is_action_pressed("ui_up"):
			velocity.y = -1
		elif event.is_action_pressed("ui_down"):
			velocity.y = 1
		elif event.is_action_released("ui_up") and !Input.is_action_pressed("ui_down"):
			velocity.y = 0
		elif event.is_action_released("ui_down") and !Input.is_action_pressed("ui_up"):
			velocity.y = 0

func _physics_process(delta):
	move_and_collide(velocity.normalized() * speed * delta)
	
	if velocity.length_squared() > 0 and !$AudioStreamPlayer.playing:
		$AudioStreamPlayer.play()
	
func kill(reason):
	alive = false
	velocity = Vector2()
	$AnimatedSprite.stop()
	$AnimatedSprite.flip_v = true
	$DeathSound.play()
	emit_signal("died", reason)
	
