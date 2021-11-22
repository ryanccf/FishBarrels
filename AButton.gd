extends Control
var event

func _ready():
	event = InputEventAction.new()
	event.action = "fire"

func _on_TouchButton_pressed():
	event.pressed = true
	Input.parse_input_event(event)
	$ButtonDown.play()

func _on_TouchButton_released():
	event.pressed = false
	Input.parse_input_event(event)
	$ButtonUp.play()
