extends KinematicBody2D	

const TIMEINCREASE = 5
const SWIM_MAX_FLOOR = 2
const SWIM_MAX_CEILING = 8
const SWIM_SPEED_FLOOR = 800
const SWIM_SPEED_CEILING = 1200

var rng = RandomNumberGenerator.new()
var swim_max
var swimtime = 0
var facing = 1
var motion = Vector2(0,0)

func _ready():
	rng.randomize()
	swim_max = rng.randf_range(SWIM_MAX_FLOOR, SWIM_MAX_CEILING)
	motion.x = rng.randf_range(SWIM_SPEED_FLOOR, SWIM_SPEED_CEILING)
	if rng.randi_range(0, 1):
		toggle_facing()

func swim_and_collide(delta):
	move_and_slide(Vector2(motion.x * delta * facing * -1, 0))
	return get_slide_count() > 0

func update_swimtime(delta):
	swimtime = fmod(swimtime + delta, swim_max)
	return swimtime > swim_max
	
func _physics_process(delta):
	if swim_and_collide(delta) or update_swimtime(delta):
		toggle_facing()

func _on_Area2D_body_entered(body):
	global.add_fish()
	global.modify_remaining_fish(-1)
	global.add_time(TIMEINCREASE)
	queue_free()
	body.get_parent().queue_free()

func toggle_facing():
	var last_position = position
	if facing == 1:
		transform = Transform2D(Vector2(transform.x.x * -1, 0), Vector2(0, 1), Vector2(0, 0))
	else:
		transform = Transform2D(Vector2(1, 0), Vector2(0, 1), Vector2(0, 0))
	position = last_position
	facing *= -1
