extends Node2D

var gameover = preload("res://GameOver.tscn").instance()

func _ready():
	global.reset_fish()
	global.initialize_fish()

func _on_Area2D_body_entered(body):
	body.get_parent().queue_free()

func _on_GameTimer_timeout():
	load_game_over()

func load_game_over():
	var screen = get_parent()
	screen.remove_child(self)
	screen.add_child(gameover)
	call_deferred("free")

func toggle_pause():
	var tree = get_tree()
	tree.paused = !tree.paused

func _process(_delta):
	if Input.is_action_just_pressed("toggle_pause"):
		toggle_pause()
	if Input.is_action_just_pressed("select"):
		global.toggle_mute()
