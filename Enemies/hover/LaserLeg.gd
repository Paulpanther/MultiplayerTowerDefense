extends RayCast


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var lasers_left = []
var lasers_right = []


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(3):
		lasers_left.append(Curve3D.new())
		lasers_right.append(Curve3D.new())
	pass # Replace with function body.



func _process(delta):
	get_parent().get_node("left_leg").global_transform
	
	var test  = Curve3D.new()
	for i in range(len(lasers_left)):
		if lasers_left[i].get_baked_length() > 3:
			cast_to()
			pass
	pass
