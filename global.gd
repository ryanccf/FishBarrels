extends Node

var gametimer
var fish = 0
var time = 0

func reset_fish():
	fish = 0
	
func add_fish(count = 1):
	fish += count

func get_fish():
	return fish

func get_time():
	return time

func set_time(new_time):
	time = new_time

func add_time(more_time):
	gametimer.start(time + more_time)
