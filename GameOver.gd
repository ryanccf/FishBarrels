extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Background/numfish.set_text(str(global.get_fish()))

func _process(_delta):
	if Input.is_action_pressed("restart"):
		load_new_game()
		#get_tree().change_scene(game)

func load_new_game():
	var daddy = get_parent()
	daddy.remove_child(self)
	daddy.add_child(load("res://Game.tscn").instance())
	call_deferred("free")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
