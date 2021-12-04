extends Timer

func _ready():
	global.gametimer = self
	start(wait_time)
	global.set_time(time_left)

func _process(_delta):
	global.set_time(time_left)
