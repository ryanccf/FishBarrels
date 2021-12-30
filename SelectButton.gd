extends Control

func _on_TouchButton_pressed():
	global.toggle_mute()
	$ButtonDown.play()

func _on_TouchButton_released():
	$ButtonUp.play()
