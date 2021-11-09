extends Timer

func _ready():
	global.gametimer = self

func _process(_delta):
	global.set_time(time_left)
