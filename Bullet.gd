extends Node2D

const UP = Vector2(0, -1)
const DOWN = Vector2(0, 1)
const SPEED = 120
const GRAVITY = 90.8 * DOWN.y

var velocity = 0

func _ready():
	set_as_toplevel(true)
	position = get_parent().barrel_position()
	rotation = get_parent().get_rotation()
	velocity = Vector2(1, 0).rotated(rotation) * SPEED

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	$KinematicBody2D.move_and_slide((velocity), UP)

func _on_VisibilityNotifier2D_screen_exited():
	$DeathTimer.start()

func _on_DeathTimer_timeout():
	queue_free()
