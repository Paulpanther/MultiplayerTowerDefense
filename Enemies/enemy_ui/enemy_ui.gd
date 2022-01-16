extends Control

onready var enemy = get_parent().get_parent()
onready var full_margin_right = $HP.margin_right

func _process(delta):
	var enemy_health = enemy.get_health()
	$HP.margin_right = enemy_health * full_margin_right
	$HP.margin_left = - $HP.margin_right
