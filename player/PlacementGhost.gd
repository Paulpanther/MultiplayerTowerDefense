extends Spatial

var placed = false
export(PackedScene) var scene
export(String) var action
export(String) var requirement_func
var place_mode = false

onready var camera = $"../../CameraOrbital"
onready var all_ghosts = $"../"

func _process(delta):
	if Input.is_action_just_pressed(action):
		if Global.call(requirement_func):
			place_mode = not place_mode
			
			if place_mode:
				all_ghosts.set_active(self)
	
	if not place_mode:
		remove_obj()
	
	if camera.get_collision_group() == "ground":
		handle_ground_hit()
	else:
		if place_mode and placed:
			placed.hide()

func handle_ground_hit():
	if place_mode:
		var point = camera.get_collision_point()
		set_scene_if_not_present()
		global_transform.origin = point
		if Input.is_action_just_pressed("rotate"):
			global_rotate(Vector3.UP, 45.0)
		
		if Input.is_action_just_pressed("mouse_click"):
			var tower = remove_obj()
			rpc("_place_in_game", tower.transform)
			place_mode = false

remotesync func _place_in_game(transform):
	var tower = scene.instance()
	tower.transform = transform
	all_ghosts.get_parent().get_parent().add_child(tower)

func set_scene_if_not_present():
	if not placed:
		placed = scene.instance()
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
