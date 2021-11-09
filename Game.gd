extends Node2D

const GAMEOVER = "res://GameOver.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	global.reset_fish()

func _on_Area2D_body_entered(body):
	body.get_parent().queue_free()


func _on_GameTimer_timeout():
	get_tree().change_scene(GAMEOVER)
