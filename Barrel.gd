extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_body_entered(body):
	body.get_parent().queue_free()

func get_top():
	return $Node2D/Water.rect_position.y

func get_bottom():
	return get_top() + $Node2D/Water.rect_size.y

func get_left():
	return $Node2D/Water.rect_position.x

func get_right():
	return get_left() + $Node2D/Water.rect_size.x

func spawn_fish(count = 1):
	for fish in count:
		#spawn foosh
		pass
