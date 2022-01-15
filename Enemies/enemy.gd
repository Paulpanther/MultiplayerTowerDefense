extends PathFollow


export var speed = 0
export var maxHP = 0
export var damage = 0


func _process(delta):
	var unit_speed = unit_offset/(offset+0.01) * speed
	if self.unit_offset + (delta * unit_speed) >= 0.99:
		print("damage " + str(Global.baseHealth))
		Global.baseHealth -= 1
		queue_free()
	else:
		self.offset += delta * speed
		
	if $RayCast.is_colliding():
		print("Found ground")
		transform.origin.y = $RayCast.get_collision_point().y
