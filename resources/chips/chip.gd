extends KinematicBody

export var max_distance = 10
export var velocity = 10
export var take_distance = 1
export var mean_ground_distance = 0.5
export var variance_ground_distance = 0.5
export var ground_hover_speed = 0.002

onready var hover_offset = OS.get_ticks_msec()

func _process(delta):
	if $RayCast.is_colliding():
		var pos = $RayCast.get_collision_point()
		var time = OS.get_ticks_msec()
		transform.origin.y = pos.y + mean_ground_distance + sin((time + hover_offset) * ground_hover_speed) * variance_ground_distance
	
	var player = _get_nearest_player()
	
	if player:
		look_at(player.transform.origin, Vector3.UP)
		move_and_slide(-transform.basis.z * velocity, Vector3.UP)
		
		if (player.transform.origin - transform.origin).length() < take_distance:
			player.take_chip()
			free()
	
func _get_nearest_player():
	var players = get_tree().get_nodes_in_group("player")
	var min_dist = 10000000
	var min_player = null
	
	for player in players:
		var dist = (player.transform.origin - transform.origin).length()
		if dist < min_dist:
			min_dist = dist
			min_player = player
	
	if min_dist > max_distance:
		return null
	
	return min_player
