extends Node2D

var gun_angle = 0
var hand_shakiness = 0
var ready_to_fire = true

func move_hand(delta):
	hand_shakiness += delta * 1.123
	gun_angle += delta
	rotation = (sin(gun_angle) * 0.85) + 30
	position.y = (sin(hand_shakiness * 2) * 6) + 120
	position.x = (sin(hand_shakiness) * 4) + 20

func _process(delta):
	move_hand(delta)
	accept_input()

func accept_input():
	if Input.is_action_just_pressed("fire"):
		if ready_to_fire:
			fire()

func fire():
	add_child(load("res://Bullet.tscn").instance())
	ready_to_fire = false
	$Reload.start()

func barrel_position():
	return $Position2D.get_global_position()

func _on_Reload_timeout():
	ready_to_fire = true
