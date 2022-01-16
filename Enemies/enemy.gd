extends PathFollow


export var speed = 0
export var maxHP = 0
export var damage = 0

var remainingHP = 0

func _ready():
	remainingHP = maxHP

func _process(delta):
	if remainingHP <= 0:
		free()
		return
		
	var unit_speed = unit_offset/(offset+0.01) * speed
	if self.unit_offset + (delta * unit_speed) >= 0.99:
		Global.rpc("remove_base_health", 1)
		queue_free()
	else:
		self.offset += delta * speed
		
	if $RayCast.is_colliding():
		transform.origin.y = $RayCast.get_collision_point().y

func get_health():
	return remainingHP/maxHP

func take_damage(damage):
	remainingHP -= damage
	
