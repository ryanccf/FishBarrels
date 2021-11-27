extends Node2D

const UP = Vector2(0, -1)
const DOWN = Vector2(0, 1)
const SPEED = 120
const GRAVITY = 90.8 * DOWN.y

var velocity = 0

func _ready():
	var gun = get_parent()
	var background = gun.get_parent()
	var barrel_position = gun.barrel_position()
	gun.remove_child(self)
	background.add_child(self)
	self.set_owner(background)
	set_global_position(barrel_position)
	rotation = gun.get_rotation()
	velocity = Vector2(1, 0).rotated(rotation) * SPEED

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	$KinematicBody2D.move_and_slide(velocity)
	
	for collision_index in range($KinematicBody2D.get_slide_count()):
		var collision_name = $KinematicBody2D.get_slide_collision(collision_index).collider.name
		if collision_name == "BarrelBody":
			queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
