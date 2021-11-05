extends Node2D

var SPEED = 200
var velocity = 0

func _ready():
	set_as_toplevel(true)
	position = get_parent().barrel_position()
	rotation = get_parent().get_rotation()
	velocity = Vector2(1, 0).rotated(rotation) * SPEED
	print(velocity)

func _physics_process(delta):
	$KinematicBody2D.move_and_collide(velocity * delta)

func _on_VisibilityNotifier2D_screen_exited():
	print("EXITED SCREEEN")
	print(position)
	$DeathTimer.start()

func _on_DeathTimer_timeout():
	queue_free()
