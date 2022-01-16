extends PathFollow


export var speed = 0
export var maxHP = 0
export var damage = 0

var health = 1.0


func _process(delta):
	if health <= 0:
		free()
		return
		
	var unit_speed = unit_offset/(offset+0.01) * speed
	if self.unit_offset + (delta * unit_speed) >= 0.99:
		print("damage " + str(Global.baseHealth))
		Global.baseHealth -= 1
		queue_free()
	else:
		self.offset += delta * speed
		
	if $RayCast.is_colliding():
		transform.origin.y = $RayCast.get_collision_point().y

func get_health():
	return health

func take_damage(damage):
	health -= damage
	
