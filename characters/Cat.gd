extends KinematicBody2D

enum State {IDLE, CHASING, FULL}

export var speed = 150

var target
var nav: Navigation2D
var paths = []
var state = State.IDLE

func _ready():
	nav = get_parent()

func _draw():
	if target:
		draw_line(Vector2(), target.position - position, Color(1.0, 0.0, 0.0), 3)

		if !paths.empty():
			var mult = 1
			draw_line(Vector2(), paths[0] - position, Color(0.0, 1.0 / mult, 0.0), 3)
			for i in range(1, paths.size()):
				mult += 1
				draw_line(paths[i - 1] - position, paths[i] - position, Color(0.0, 1.0 / mult, 0.0), 3)

func _physics_process(delta):
	update()
	if target and state == State.IDLE:
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(position, target.position,
					[self, target], collision_mask)
		if result.empty():
			state = State.CHASING
	
	elif state == State.CHASING:
		assert(target)
		paths = nav.get_simple_path(position, target.position)
		assert(paths.size() > 1)
		move_and_slide((paths[1] - position).normalized() * speed)
		for i in get_slide_count():
			var collider = get_slide_collision(i).get_collider()
			if collider.is_in_group("player"):
				state = State.FULL
				collider.kill("feline fatality")
			elif collider.is_in_group("fish"):
				state = State.FULL

func _on_Smell_body_entered(body):
	if state == State.IDLE:
		if body.is_in_group("player"):
			target = body
	if state == State.CHASING:
		if body.is_in_group("fish"):
			target = body
