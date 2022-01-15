extends PathFollow


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 0
export var maxHP = 0
export var damage = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var unit_speed = unit_offset/(offset+0.01) * speed
	if self.unit_offset + (delta * unit_speed) >= 0.99:
		print("damage " + str(Global.baseHealth))
		Global.baseHealth -= 1
		queue_free()
	else:
		self.offset += delta * speed
