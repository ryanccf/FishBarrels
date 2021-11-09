extends Node2D

var game = "res://Game.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Background/numfish.set_text(str(global.get_fish()))

func _process(_delta):
	if Input.is_action_pressed("fire"):
		get_tree().change_scene(game)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
