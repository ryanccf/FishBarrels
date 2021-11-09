extends Label

func _ready():
	update_score()

func update_score():
	text = str(ceil(get_parent().get_parent().get_node("GameTimer").time_left))

func _process(delta):
	update_score()
