extends Control

func _on_TouchButton_pressed():
	$ButtonDown.play()

func _on_TouchButton_released():
	$ButtonUp.play()
