extends KinematicBody2D

enum State {CHASING, HAPPY}

export var speed = 150

var hungry = true
var fish = false
var target = self

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func chase(node):
	target = node

func _physics_process(delta):
	if hungry:
		var direction = (target.position - position).normalized()
		var collision = move_and_collide(direction * speed * delta)
		if collision != null and collision.collider.is_in_group("player"):
			collision.collider.kill("feline fatality")
			hungry = false
		


func _on_Smell_body_entered(body):
	if hungry:
		if body.is_in_group("fish"):
			target = body
			fish = true
		elif !fish and body.is_in_group("player"):
			target = body
