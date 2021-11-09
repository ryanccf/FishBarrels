extends Label

func _ready():
	update_score()

func update_score():
	text = str(ceil(global.get_time()))

func _process(delta):
	update_score()
