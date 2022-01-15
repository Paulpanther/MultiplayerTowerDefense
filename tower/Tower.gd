extends Spatial

export var shoot_delay = 200

var last_shoot = 0


func set_ghost(enable):
	pass

func _process(delta):
	var time = OS.get_ticks_msec()
	
	if time - last_shoot > shoot_delay:
		last_shoot = time
		_shoot()

func _shoot():
	var enemy = _get_nearest_enemy()
	if not enemy:
		return
	
	look_at(enemy.transform.origin, Vector3.UP)
	

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
