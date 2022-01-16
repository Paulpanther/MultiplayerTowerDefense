extends PanelContainer

onready var margin_width = margin_right
onready var full_health = float(Global.baseHealth)
func _process(delta):
	margin_right = (Global.baseHealth/full_health) * margin_width
