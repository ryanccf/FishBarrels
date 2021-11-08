extends Label

func _ready():
	update_score()

func update_score():
	text = str(global.get_fish())

func _process(delta):
	update_score()
