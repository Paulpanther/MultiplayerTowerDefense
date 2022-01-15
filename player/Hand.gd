extends Spatial

var tower_scene = preload("res://tower/Tower.tscn")

var tower_place_mode = false

func _process(delta):
	var player = get_parent()
	
	if not player.is_network_master():
		return
		
	var ray = $RayCast
	var game = player.get_parent()
	var ghost = player.get_node("TowerGhost")
	
	if Input.is_action_just_pressed("place_tower_mode"):
		tower_place_mode = not tower_place_mode
		
		if not tower_place_mode:
			ghost.remove_obj()
	
	if tower_place_mode and ray.is_colliding():
		var point = ray.get_collision_point()
		ghost.set_scene_if_not_present()
		ghost.global_transform.origin = point
		
		if Input.is_action_just_pressed("mouse_click"):
			var tower = ghost.remove_obj()
			rpc("_place_tower_in_game", tower.transform)
			tower_place_mode = false

remotesync func _place_tower_in_game(transform):
	var tower = tower_scene.instance()
	tower.transform = transform
	get_parent().get_parent().add_child(tower)
			
