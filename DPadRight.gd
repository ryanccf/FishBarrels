extends Control

func _on_TextureButton_button_down():
	$ButtonDown.play()

func _on_TextureButton_button_up():
	$ButtonUp.play()
