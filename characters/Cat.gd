extends KinematicBody2D

enum State {IDLE, CHASING, FULL}

export var speed = 150
export var smell_radius: float

var target
var nav: Navigation2D
var state = State.IDLE

func _ready():
	nav = get_parent()
	var circle = CircleShape2D.new()
	circle.radius = smell_radius
	var collider = CollisionShape2D.new()
	collider.shape = circle
	var area = Area2D.new()
	area.add_child(collider)
	add_child(area)
	area.connect("body_entered", self, "_on_Smell_body_entered")

func _process(delta):
	var tick = float(OS.get_ticks_msec()) / 300.0
	var r = .5 * (1 + sin(tick))

	#$Status.modulate = Color(1.0, r, r)
	$Status.modulate.a = r

func _physics_process(delta):
	if target and state == State.IDLE:
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(position, target.position,
					[self, target], collision_mask)
		if result.empty():
			state = State.CHASING
	
	elif state == State.CHASING:
		assert(target)
		var paths = nav.get_simple_path(position, target.position)
		assert(paths.size() > 1)
		move_and_slide((paths[1] - position).normalized() * speed)
		for i in get_slide_count():
			var collider = get_slide_collision(i).get_collider()
			if collider.is_in_group("player"):
				state = State.FULL
				collider.kill("feline fatality")
			elif collider.is_in_group("fish"):
				state = State.FULL
				$Status/Chasing.hide()
				$Status/Full.show()
				update()

func _on_Smell_body_entered(body):
	if state == State.IDLE:
		if body.is_in_group("player"):
			target = body
			$Status/Chasing.show()
			
	if state == State.CHASING:
		if body.is_in_group("fish"):
			target = body
			$Status/Chasing.show()
