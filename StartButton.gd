extends Control

func _on_TouchButton_pressed():
	$ButtonDown.play()
	Input.vibrate_handheld(100)

func _on_TouchButton_released():
	$ButtonUp.play()
	Input.vibrate_handheld(500)
