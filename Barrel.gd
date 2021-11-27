extends Node2D

var rng = RandomNumberGenerator.new()
var fishasset = preload("res://Fish.tscn")

func _ready():
	spawn_fish(5)
	
func _process(delta):
	if global.get_remaining_fish() < 1:
		spawn_fish(5)
		global.modify_remaining_fish(5)

func _on_Area2D_body_entered(body):
	print(body.name + "entered barrel wall")
#	body.get_parent().queue_free()

func get_top():
	return $Node2D/Water.rect_position.y - 200

func get_bottom():
	return get_top() + $Node2D/Water.rect_size.y + 5

func get_left():
	return $Node2D/Water.rect_position.x  - 55# + 15

func get_right():
	return get_left() + $Node2D/Water.rect_size.x  - 50# - 30
	
func get_random_x():
	rng.randomize()
	return rng.randf_range(get_left(), get_right())

func get_random_y():
	rng.randomize()
	return rng.randf_range(get_left(), get_right())
	
func get_spawn_position():
	return Vector2(get_random_x(), 65)

func spawn_fish(count = 1):
	for item in range(count):
		var foosh = fishasset.instance()
		var pos = get_spawn_position()
		pos.y -= (15 * item)
		foosh.set_position(pos) 
		$Node2D/Water.add_child(foosh)
