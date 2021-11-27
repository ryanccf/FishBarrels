extends KinematicBody2D	

const TIMEINCREASE = 5
const SWIM_MAX_FLOOR = 2
const SWIM_MAX_CEILING = 8
const SWIM_SPEED_FLOOR = 800
const SWIM_SPEED_CEILING = 1200


var rng = RandomNumberGenerator.new()

var swim_max = 300
var swimtime = 0
var facing = 1
var FLIP_X
var swim_speed = 0.2
var speed = 750
var velocity = Vector2()
var motion = Vector2(0,0)

func _ready():
	rng.randomize()
	swim_max = rng.randf_range(SWIM_MAX_FLOOR, SWIM_MAX_CEILING)
	motion.x = rng.randf_range(SWIM_SPEED_FLOOR, SWIM_SPEED_CEILING)
	if rng.randi_range(0, 1):
		toggle_facing()

func swim_and_collide(delta):
	move_and_slide(Vector2(motion.x * delta * facing * -1, 0))
	if get_slide_count() > 0:
		return true

func check_swimtime(delta):
	swimtime += delta
	if swimtime > swim_max:
		#Carry remainder to next loop.
		swimtime = fmod(swimtime, swim_max)
		return true
	
func _physics_process(delta):
	if swim_and_collide(delta) or check_swimtime(delta):
		toggle_facing()

func add_random_rotation():
	rotate(90)

func _on_Area2D_body_entered(body):
	global.add_fish()
	global.modify_remaining_fish(-1)
	global.add_time(TIMEINCREASE)
	queue_free()
	body.get_parent().queue_free()

#func _on_Area2D2_area_entered(area):
#	print("Fish collided with " + area.get_name())
	#toggle_facing()
	#add_random_rotation()

func toggle_facing():
	var last_position = position
	if facing == 1:
		transform = Transform2D(Vector2(transform.x.x * -1, 0), Vector2(0, 1), Vector2(0, 0))
	else:
		transform = Transform2D(Vector2(1, 0), Vector2(0, 1), Vector2(0, 0))
	position = last_position
	facing *= -1
	
	#transform = Transform2D(Vector2(transform.x.x * -1, 0), Vector2(0, 1), transform.origin)
	#Identity transform:
	#transform = Transform2D(Vector2(1, 0), Vector2(0, 1), transform.origin)
#	Rotate 45 degrees:

#	var angle = rng.randf_range(0, 0.5)*PI
#	transform = Transform2D(Vector2(cos(angle), sin(angle)), Vector2(-sin(angle), cos(angle)), transform.origin)
