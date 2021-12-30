extends Node

var gametimer
var remaining_fish = 0
var fish = 0
var time = 0
var main_mute = false;

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
	
func initialize_fish(starting_fish = 5):
	remaining_fish = starting_fish
	
func modify_remaining_fish(more_fish):
	remaining_fish += more_fish

func get_remaining_fish():
	return remaining_fish

func toggle_mute():
	AudioServer.set_bus_mute(0, !AudioServer.is_bus_mute(AudioServer.get_bus_index("Master")))
