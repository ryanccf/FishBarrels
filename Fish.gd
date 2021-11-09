extends Node2D

const TIMEINCREASE = 5

var rng = RandomNumberGenerator.new()

var swim_max = 300
var swimtime = 0
var facing = -1
#var FLIP_X

func _ready():
	rng.randomize()
	swim_max = rng.randf_range(20, 300)

func _process(delta):
	position.x += delta * 10 * facing
	check_swimtime()

func check_swimtime():
	if swimtime < swim_max:
		swimtime += 1
	else:
		toggle_facing()
		swimtime = 0
	
func check_facing():
	var last_position = position
	if facing == -1:
		position = last_position
	else:
		Transform2D.affine_inverse()

func toggle_facing():
	facing *= -1
	transform = Transform2D(Vector2(transform.x.x * -1, 0), Vector2(0, 1), transform.origin)
	#Identity transform:
	#transform = Transform2D(Vector2(1, 0), Vector2(0, 1), transform.origin)
	#Rotate 45 degrees:
	#var angle = 	rng.randf_range(0, 2)*PI
	#transform = Transform2D(Vector2(cos(angle), sin(angle)), Vector2(-sin(angle), cos(angle)), transform.origin)

	
#	if facing == 1:
#		transform = Transform2D(Vector2(transform.x.x * -1, 0), Vector2(0, 1), Vector2(0, 0)
#		var last_position = position
#		transform = FLIP_X
#		position = last_position
#	else:
#		var FLIP_X = Transform2D(Vector2(1, 0), Vector2(0, 1), Vector2(0, 0))
#		var last_position = position
#		transform = FLIP_X
#		position = last_position

func _on_Area2D_area_entered(area):
	toggle_facing()


func _on_Area2D_body_entered(body):
	global.add_fish()
	global.add_time(TIMEINCREASE)
	queue_free()
	body.get_parent().queue_free()
