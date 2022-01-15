extends Node


func set_scene_if_not_present(scene: PackedScene):
	if get_child_count() == 0:
		var instance = scene.instance()
		add_child(instance)

func remove_obj():
	pass

