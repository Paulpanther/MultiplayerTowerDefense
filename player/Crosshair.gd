extends Sprite3D

onready var camera_orbital = get_parent().get_parent()
onready var crosshair_tex = preload("res://assets/crosshair.png")
onready var turm_tex = preload("res://assets/turm.png")


func switch_crosshair(group):
	pass
	#if group == "rock":
	#	set_texture(turm_tex)



func _process(delta):
	var collision_group = camera_orbital.get_collision_group()
	set_texture(crosshair_tex)
	switch_crosshair(collision_group)
