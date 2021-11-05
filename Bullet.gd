extends Node2D

func _ready():
	print(get_parent().name)
	global_position = get_parent().global_position
	set_as_toplevel(true)
	position = get_parent().get_position()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
