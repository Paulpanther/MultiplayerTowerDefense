extends Control

onready var max_hp = float(Global.baseHealth)
onready var full_margin_right = $HP.margin_right

func _process(delta):
	$HP.margin_right = (Global.baseHealth / max_hp) * full_margin_right

