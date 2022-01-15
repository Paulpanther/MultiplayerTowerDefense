extends Node


func _process(delta):
	var ray = $RayCast
	var player = get_parent()
	
	if ray.is_colliding():
		var point = ray.get_collision_point()
		var ghost = player.get_node("PlacementGhost")
