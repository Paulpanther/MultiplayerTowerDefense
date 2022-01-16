extends Spatial

var placed = false
var tower_scene = preload("res://tower/Tower.tscn")
var tower_place_mode = false

onready var camera = $"../CameraOrbital"

func _process(delta):
	if Input.is_action_just_pressed("place_tower_mode"):
		tower_place_mode = not tower_place_mode
		
		if not tower_place_mode:
			remove_obj()
	
	if camera.get_collision_group() == "ground":
		handle_ground_hit()
	else:
		if tower_place_mode and placed:
			placed.hide()

func handle_ground_hit():
	if tower_place_mode:
		var point = camera.get_collision_point()
		set_scene_if_not_present()
		global_transform.origin = point
		
		if Input.is_action_just_pressed("mouse_click"):
			var tower = remove_obj()
			rpc("_place_tower_in_game", tower.transform)
			tower_place_mode = false

remotesync func _place_tower_in_game(transform):
	var tower = tower_scene.instance()
	tower.transform = transform
	get_parent().get_parent().add_child(tower)

func set_scene_if_not_present():
	if not placed:
		placed = tower_scene.instance()
		placed.set_ghost(true)
		add_child(placed)
	placed.show()

func remove_obj():
	if placed:
		remove_child(placed)
		placed.global_transform = self.global_transform
		var p = placed
		placed = false
		return p
