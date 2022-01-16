extends PathFollow


export var speed = 0
export var maxHP = 0
export var damage = 0

var remainingHP = 0

var chip_scene = preload("res://resources/chips/chip.tscn")
onready var game = get_parent().get_parent().get_parent()

func _ready():
	remainingHP = maxHP

func _process(delta):
	if remainingHP <= 0:
		var chip = chip_scene.instance()
		chip.global_transform.origin = global_transform.origin
		game.add_child(chip)
		kill()
		return
		
	var unit_speed = unit_offset/(offset+0.01) * speed
	if self.unit_offset + (delta * unit_speed) >= 0.99:
		Global.rpc("remove_base_health", 1)
		kill()
	else:
		self.offset += delta * speed
		
	if $RayCast.is_colliding():
		transform.origin.y = $RayCast.get_collision_point().y

func get_health():
	return remainingHP * 1.0 / maxHP

remotesync func take_damage(damage):
	remainingHP -= damage
	print(remainingHP)

remotesync func kill():
	queue_free()
	
