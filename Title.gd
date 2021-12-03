extends Node2D

var game = preload("res://Game.tscn").instance()

func _ready():
	$Background/Background/Dialog.on_complete(funcref(self, "load_game"))

func load_game():
	var screen = get_parent()
	screen.remove_child(self)
	screen.add_child(game)
	call_deferred("free")
	
func toggle_pause():
	var tree = get_tree()
	tree.paused = !tree.paused

func _process(_delta):
	if Input.is_action_just_pressed("toggle_pause"):
		toggle_pause()
