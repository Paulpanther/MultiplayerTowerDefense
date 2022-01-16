extends Spatial

export var shoot_delay = 200
export var rotation_speed = 2

var last_shoot = 0
var last_side_left = false
var following_enemy

func set_ghost(enable):
	pass

func _process(delta):
	var time = OS.get_ticks_msec()
			
	if not is_instance_valid(following_enemy):
		following_enemy = null
	
	if time - last_shoot > shoot_delay:
		last_shoot = time
		_shoot()
	
	if following_enemy:
		_interpolate_rotation(delta)
		#look_at(following_enemy.transform.origin, Vector3.UP)

func _interpolate_rotation(delta):
	var final = transform.looking_at(following_enemy.transform.origin, Vector3.UP)
	transform.basis.x = lerp(transform.basis.x, final.basis.x, delta * rotation_speed)
	transform.basis.y = lerp(transform.basis.y, final.basis.y, delta * rotation_speed)
	transform.basis.z = lerp(transform.basis.z, final.basis.z, delta * rotation_speed)

func _shoot():
	var enemy = _get_nearest_enemy()
	if not enemy:
		return
	following_enemy = enemy
	
	_get_current_nozzle().get_node("Particles").restart()
	_play_shoot_animation()
	last_side_left = not last_side_left
	

func _get_nearest_enemy():
	var enemies = get_tree().get_nodes_in_group("enemy")
	var min_dist = 10000000
	var min_enemy = null
	
	for enemy in enemies:
		var dist = (enemy.transform.origin - transform.origin).length()
		if dist < min_dist:
			min_dist = dist
			min_enemy = enemy
	return min_enemy

func _play_shoot_animation():
	var player = $"gun_turret/AnimationPlayer"
	player.play("default")

func _get_current_nozzle():
	if last_side_left:
		return $NozzleLeft
	else:
		return $NozzleRight
