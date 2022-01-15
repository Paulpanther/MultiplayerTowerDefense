extends Node

var placed = false

func set_scene_if_not_present(scene: PackedScene):
	if not placed:
		placed = scene.instance()
		placed.set_ghost(true)
		add_child(placed)

func remove_obj():
	if placed:
		placed.set_ghost(false)
		remove_child(placed)
		placed.global_transform.origin = self.global_transform.origin
		var p = placed
		placed = false
		return p
