extends Node

var tower = preload("res://tower/Tower.tscn")


var tower_place_mode = false

func _process(delta):
	var ray = $RayCast
	var player = get_parent()
	var game = player.get_parent()
	var ghost = player.get_node("PlacementGhost")
	
	if Input.is_action_just_pressed("place_tower_mode"):
		tower_place_mode = not tower_place_mode
		
		if not tower_place_mode:
			ghost.remove_obj()
	
	if tower_place_mode and ray.is_colliding():
		var point = ray.get_collision_point()
		ghost.set_scene_if_not_present(tower)
		ghost.global_transform.origin = point
		
		if Input.is_action_just_pressed("mouse_click"):
			game.add_child(ghost.remove_obj())
			tower_place_mode = false
	else:
		print(ray.is_colliding())
			
