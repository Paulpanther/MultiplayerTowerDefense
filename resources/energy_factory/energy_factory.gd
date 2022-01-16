extends Node

export var energy = 10
var is_ghost = false

func _ready():
	if not is_ghost:
		Global.Energy += energy
		Global.Chips -= Global.energy_factory_chips_cost

func set_ghost(enable):
	is_ghost = enable
