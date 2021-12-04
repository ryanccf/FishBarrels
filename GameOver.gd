extends Node2D

func _ready():
	set_numerical_value($Background/numfish, global.get_fish())
	update_personal_best()

func update_personal_best():
	save_personal_best(max(load_personal_best(), get_numerical_value($Background/numfish)))
	
func load_personal_best():
	var loading_file = File.new()
	if not loading_file.file_exists("user://savegame.save"):
		return 0
	else:
		loading_file.open("user://savegame.save", File.READ)
		return int(loading_file.get_as_text().strip_edges(true, true))

func save_personal_best(new_best):
	set_numerical_value($Background/personal_best, new_best)
	var saving_file = File.new()
	saving_file.open("user://savegame.save", File.WRITE)
	saving_file.store_line(str(new_best))
	saving_file.close()

func get_numerical_value(text_node):
	return int(text_node.get_text())

func set_numerical_value(text_node, score):
	text_node.set_text(str(score))

func _process(_delta):
	if Input.is_action_pressed("restart"):
		load_new_game()

func load_new_game():
	var daddy = get_parent()
	daddy.remove_child(self)
	daddy.add_child(load("res://Game.tscn").instance())
	call_deferred("free")
