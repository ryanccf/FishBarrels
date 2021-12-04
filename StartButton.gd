extends Control

var event

func _ready():
	event = InputEventAction.new()
	event.action = "toggle_pause"
	
func _on_TouchButton_pressed():
	event.pressed = true
	Input.parse_input_event(event)
	$ButtonDown.play()
	Input.vibrate_handheld(100)

func _on_TouchButton_released():
	event.pressed = false
	Input.parse_input_event(event)
	$ButtonUp.play()
	Input.vibrate_handheld(500)
