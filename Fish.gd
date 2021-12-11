extends KinematicBody2D	

const TIMEINCREASE = 1.5
const SWIM_MAX_FLOOR = 2
const SWIM_MAX_CEILING = 8
const SWIM_SPEED_FLOOR = 800
const SWIM_SPEED_CEILING = 1200
const BOBBING_AMPLITUDE_FLOOR = 1
const BOBBING_AMPLITUDE_CEILING = 8
const BOBBING_FREQUENCY_FLOOR = 1
const BOBBING_FREQUENCY_CEILING = 8 


var rng = RandomNumberGenerator.new()
var swim_max
var swimtime = 0
var facing = 1
var motion = Vector2(0,0)
var running_delta = 0
var bobbing_amplitude
var bobbing_frequency
var action_on_death

func _ready():
	rng.randomize()
	swim_max = rng.randf_range(SWIM_MAX_FLOOR, SWIM_MAX_CEILING)
	motion.x = rng.randf_range(SWIM_SPEED_FLOOR, SWIM_SPEED_CEILING)
	bobbing_amplitude = rng.randf_range(BOBBING_AMPLITUDE_FLOOR, BOBBING_AMPLITUDE_CEILING)
	bobbing_frequency = rng.randf_range(BOBBING_FREQUENCY_FLOOR, BOBBING_FREQUENCY_CEILING)
	if rng.randi_range(0, 1):
		toggle_facing()

func swim_and_collide(delta):
	running_delta = fmod(running_delta + delta, 2*PI)
	var x_motion = motion.x * delta * facing * -1
	var y_motion = sin(running_delta * bobbing_frequency) * bobbing_amplitude
	move_and_slide(Vector2(x_motion, y_motion))	
	for collision_index in range(get_slide_count()):
		var collision_name = get_slide_collision(collision_index).collider.name
		if collision_name == "BarrelSides":
			return true

func update_swimtime(delta):
	swimtime += delta
	var status = swimtime > swim_max
	swimtime = fmod(swimtime, swim_max)
	return status
	
func _physics_process(delta):
	if swim_and_collide(delta) or update_swimtime(delta):
		toggle_facing()

func _on_Area2D_body_entered(body):
	global.add_fish()
	global.modify_remaining_fish(-1)
	global.add_time(TIMEINCREASE)
	queue_free()
	body.get_parent().queue_free()
	if action_on_death:
		action_on_death.call_func()

func toggle_facing():
	var last_position = position
	if facing == 1:
		transform = Transform2D(Vector2(transform.x.x * -1, 0), Vector2(0, 1), Vector2(0, 0))
	else:
		transform = Transform2D(Vector2(1, 0), Vector2(0, 1), Vector2(0, 0))
	position = last_position
	facing *= -1

func on_death(function_reference):
	action_on_death = function_reference
