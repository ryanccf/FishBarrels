extends Label

var seconds_per_character = 0.33333
var seconds_to_next_character
var next_text
var on_complete_event 
var on_complete_delay = 0

func reset_timer(offset = 0):
	seconds_to_next_character = seconds_per_character - offset

func is_text_done():
	return next_text.length() == 0

func is_delay_done():
	return on_complete_delay < 0

func adjust_timer(delta):
	seconds_to_next_character -= delta
	if is_text_done():
		on_complete_delay -= delta

func modify_text():
	if seconds_to_next_character <= 0:
		text += next_text.substr(0, 1)
		next_text = next_text.substr(1, next_text.length())
		reset_timer(abs(seconds_to_next_character))
	
func _ready():
	next_text = text
	text = ""
	reset_timer()
	var reffie = funcref(self, "method_name")
	on_complete(reffie, 0)

func method_name():
	print("STUFF")

func _process(delta):
	if not is_delay_done():
		adjust_timer(delta)
		modify_text()
	elif on_complete_event:
		on_complete_event.call_func()
		on_complete_event = false
		
func set_characters_per_second(count):
	if count >= 0:
		seconds_per_character = 1 / abs(count)
	else:
		seconds_per_character = 9000

func on_complete(event, milliseconds_of_delay = 0):
	on_complete_event = event
	on_complete_delay = milliseconds_of_delay

# Use on_complete like this from another class:
#	var reffie = funcref(self, "method_name")
#	on_complete(reffie, 0)
#
#func method_name():
#	print("STUFF")
