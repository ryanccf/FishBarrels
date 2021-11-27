extends Node2D

func _ready():
	$Background/numfish.set_text(str(global.get_fish()))

func _process(_delta):
	if Input.is_action_pressed("restart"):
		load_new_game()

func load_new_game():
	var daddy = get_parent()
	daddy.remove_child(self)
	daddy.add_child(load("res://Game.tscn").instance())
	call_deferred("free")
