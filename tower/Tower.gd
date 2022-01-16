extends Spatial

export var shoot_delay = 200
export var rotation_speed = 2
export var enemy_damage = 0.1
export var max_distance = 50

var last_shoot = 0
var last_side_left = false
var following_enemy
var is_ghost = false

var soundShoot1 = load("res://tower/gun_turret/medium_gun.mp3")
var audio = AudioStreamPlayer3D.new()

func _ready():
	$Range.scale = Vector3(max_distance, max_distance, max_distance)
	if not is_ghost:
		Global.Energy -= Global.tower_energy_cost

func set_ghost(enable):
	is_ghost = enable
	if is_ghost:
		$Range.show()

func _process(delta):
	if is_ghost:
		return
	
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
	var final_quat = Quat(final.basis)
	var to_quat = Quat(transform.basis).slerp(final_quat, delta * rotation_speed)
	transform.basis = Basis(to_quat)

func _shoot():
	var enemy = _get_nearest_enemy()
	if not enemy:
		return
	following_enemy = enemy
	
	_get_current_nozzle().get_node("Particles").restart()
	_play_shoot_animation()
	
	$shoot.play()
	
	last_side_left = not last_side_left
	following_enemy.take_damage(enemy_damage)
	

func _get_nearest_enemy():
	var enemies = get_tree().get_nodes_in_group("enemy")
	var min_dist = 10000000
	var min_enemy = null
	
	for enemy in enemies:
		var dist = (enemy.transform.origin - transform.origin).length()
		if dist < min_dist:
			min_dist = dist
			min_enemy = enemy
	if min_dist > max_distance:
		return null
	return min_enemy

func _play_shoot_animation():
	var player = $"gun_turret/AnimationPlayer"
	player.play("default")

func _get_current_nozzle():
	if last_side_left:
		return $NozzleLeft
	else:
		return $NozzleRight
