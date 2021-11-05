extends Node2D

var gun_angle = 0
var hand_shakiness = 0

func _ready():
	pass

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
	if Input.is_action_pressed("fire"):
		add_child(load("res://Bullet.tscn").instance())

func barrel_position():
	return $Position2D.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
