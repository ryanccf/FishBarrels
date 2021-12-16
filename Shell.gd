extends Node2D

const UP = Vector2(0, -1)
const DOWN = Vector2(0, 1)
const SPEED = 40
const SPEED_FLOOR = 35
const SPEED_CEILING = 45
const SPIN_FLOOR = 2
const SPIN_CEILING = 8
var speed
var spin
var rng = RandomNumberGenerator.new()

const GRAVITY = 90.8 * DOWN.y

var velocity = 0

func _ready():
	rng.randomize()
	speed = rng.randf_range(SPEED_FLOOR, SPEED_CEILING)
	spin = rng.randf_range(SPIN_FLOOR, SPIN_CEILING)
	print(spin)
	
	var gun = get_parent()
	var background = gun.get_parent()
	var ejector_position = gun.get_ejector_position()
	gun.remove_child(self)
	background.add_child(self)
	self.set_owner(background)
	set_global_position(ejector_position)
	rotation = gun.get_rotation()
	velocity = Vector2(-0.2, -1).rotated(rotation) * SPEED
	#$KinematicBody2D.set_angular_velocity(15)

func _physics_process(delta):
	$KinematicBody2D.rotate(-1 * delta * spin)
	$KinematicBody2D.move_and_slide(velocity)
	
	#for collision_index in range($KinematicBody2D.get_slide_count()):
	#	var collision_name = $KinematicBody2D.get_slide_collision(collision_index).collider.name
	#	if collision_name == "BarrelSides" or collision_name == "BarrelBottom":
	#		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
