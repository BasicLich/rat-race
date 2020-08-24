extends KinematicBody2D

enum State {IDLE, CHASING, FULL}

export var speed = 150
export var smell_radius: float

var target
var nav: Navigation2D
export var state = State.IDLE

func _ready():
	if state == State.FULL:
		_begin_full_state()
	
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
	var tick = float(OS.get_ticks_msec()) / 200.0
	$Status.modulate.a = .5 * (1 + sin(tick))

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
				_begin_full_state()
				collider.kill("feline fatality")
			elif collider.is_in_group("fish"):
				$Status/Full.show()
				_begin_full_state()
	elif state == State.FULL:
		assert(target)
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(position, target.position,
					[self, target], collision_mask)
		if !result:
			var paths = nav.get_simple_path(position, target.position)
			assert(paths.size() > 1)
			var normalized = (paths[1] - position).normalized()
			if (paths[1] - position).length_squared() > (speed): 
				move_and_slide(normalized * speed)

func _begin_full_state():
	state = State.FULL
	$Status/Full.show()
	target = Node2D.new()
	$Timer.start()
	

func _on_Smell_body_entered(body):
	if state == State.IDLE:
		if body.is_in_group("player"):
			target = body
			#$Status/Chasing.show()
			
	if state == State.CHASING:
		if body.is_in_group("fish"):
			target = body
			#$Status/Chasing.show()


func _on_Timer_timeout():
	#print(Vector2((randi() % 100) - 50, (randi() % 100) - 50))
	target.position = nav.get_closest_point(position + Vector2((randi() % 100) - 50, (randi() % 100) - 50))
	
