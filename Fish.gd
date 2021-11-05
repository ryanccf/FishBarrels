extends Node2D
const SWIM_MAX = 300
var swimtime = 0
var facing = -1

func _ready():
	pass

func _process(delta):
	position.x += delta * 10 * facing
	check_swimtime()
	#check_facing()

func check_swimtime():
	if swimtime < SWIM_MAX:
		swimtime += 1
	else:
		toggle_facing()
		swimtime = 0
	
func check_facing():
	if facing == -1:
		position *= Vector2(-1, 0)
		pass
	else:
		pass
		position *= Vector2(-1, 1)

func toggle_facing():
	facing *= -1

func _on_Area2D_area_entered(area):
	toggle_facing()
