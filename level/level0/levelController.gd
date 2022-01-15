extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func genPath(path):
	path.curve.add_point(Vector3(0,0,0))
	path.curve.add_point(Vector3(10,10,10))
	
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	var enemy_path = $enemy_path
	print(self.get_child(0).name)
	var path = genPath(enemy_path)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var pf = $enemy_path/enemy_path_follow
	pf.unit_offset += delta/15
	pass
