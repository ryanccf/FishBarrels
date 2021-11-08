extends Node

var fish = 0

func reset_fish():
	fish = 0
	
func add_fish(count = 1):
	fish += count

func get_fish():
	return fish
