extends Node

var placed = false
var tower = preload("res://tower/Tower.tscn")

func set_scene_if_not_present():
	if not placed:
		placed = tower.instance()
		placed.set_ghost(true)
		add_child(placed)

func remove_obj():
	if placed:
		placed.set_ghost(false)
		remove_child(placed)
		placed.global_transform = self.global_transform
		var p = placed
		placed = false
		return p
