extends KinematicBody2D

export var speed = 200
var velocity = Vector2()
var direction = 0

#func _input(event):
#	if event.is_action_pressed("ui_left"):
#		direction = -1
#	elif event.is_action_pressed("ui_right"):
#		direction = 1

func get_input():
	# Detect up/down/left/right keystate and only move when pressed.
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	move_and_collide(velocity * delta)