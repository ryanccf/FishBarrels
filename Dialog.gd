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

func append_next_character():
	text += next_text.substr(0, 1)
	next_text = next_text.substr(1, next_text.length())

func is_next_character_space(text):
	var ascii_bytes = next_text.substr(0, 1).to_ascii()
	if ascii_bytes.size() > 0:
		return str(ascii_bytes[0]) == "32"

func modify_text():
	if seconds_to_next_character <= 0:
		append_next_character()
		while is_next_character_space(next_text):
			append_next_character()
		reset_timer(abs(seconds_to_next_character))

func _ready():
	next_text = text
	text = ""
	reset_timer()
	var reffie = funcref(self, "method_name")
	on_complete(reffie, 0)

func handle_input():
	if Input.is_action_just_pressed("fire") or Input.is_action_just_pressed("restart"):
		return true

func _process(delta):		
	
	set("custom_colors/default_color", Color(1, 1, 1, 1))
	
	
	if handle_input() or is_delay_done():
		on_complete_event.call_func()
	else:
		adjust_timer(delta)
		modify_text()

func set_characters_per_second(count):
	if count >= 0:
		seconds_per_character = 1 / abs(count)
	else:
		seconds_per_character = 9000

func on_complete(event, seconds_of_delay = 2):
	on_complete_event = event
	on_complete_delay = seconds_of_delay

# Use on_complete like this from another class:
#	var reffie = funcref(self, "method_name")
#	on_complete(reffie, 0)
#
#func method_name():
#	print("STUFF")
