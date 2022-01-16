extends Node


func set_active(ghost):
	for child in get_children():
		if child != ghost:
			child.place_mode = false
