extends Node2D

#var fishy = preload("res://Fish.tscn")
# Called when the node enters the scene tree for the first time.
var rng = RandomNumberGenerator.new()

func _ready():
	spawn_fish(5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_body_entered(body):
	body.get_parent().queue_free()

func get_top():
	return $Node2D/Water.rect_position.y - 200

func get_bottom():
	return get_top() + $Node2D/Water.rect_size.y + 5

func get_left():
	return $Node2D/Water.rect_position.x + 15

func get_right():
	return get_left() + $Node2D/Water.rect_size.x - 30
	
func get_random_x():
	rng.randomize()
	return rng.randf_range(get_left(), get_right())

func get_random_y():
	rng.randomize()
	return rng.randf_range(get_left(), get_right())
	
func get_spawn_position():
	
	return Vector2(get_random_x(), get_random_y())

#	return Vector2(get_middle_x(), get_middle_y())

func spawn_fish(count = 1):
	#for item in count:
	#var foosh = fishy.instance()
	for cunt in range(count):
		var foosh = load("res://Fish.tscn").instance()
		add_child(foosh)
		var pos = get_spawn_position()

		foosh.set_position(pos) 
		$Node2D/Water.add_child(foosh)
