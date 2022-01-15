extends Node

var tower = preload("res://tower/Tower.tscn")


func _process(delta):
	var ray = $RayCast
	var player = get_parent()
	
	if ray.is_colliding():
		print(ray.get_collider())
		var point = ray.get_collision_point()
		var ghost = player.get_node("PlacementGhost")
		ghost.set_scene_if_not_present(tower)
		ghost.global_transform.origin = point
