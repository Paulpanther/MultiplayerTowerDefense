extends Control

onready var ui = get_parent()
onready var tex = "res://assets/crosshair.png"

func _ready():
	var canvas = ui.get_global_transform()
	
	set_position(canvas)
	#draw_texture(tex, canvas.x * .5 + canvas.z * 0.5)
