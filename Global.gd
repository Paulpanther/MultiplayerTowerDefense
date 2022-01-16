extends Node

export var currentHealth = 100

#GAMESTATE
export var difficulty = 0

#BASE
export var baseHealth = 150

#Rescources
export var Chips = 10
export var Energy = 0

export var energy_factory_chips_cost = 1
export var tower_energy_cost = 10

#ENEMIES
enum ENEMIES{
	grunt,
	runner
}

export(ENEMIES) var enemies = ENEMIES.grunt

#LEVELS
export var startDelay = 30
export var stateTimer = 0
export var maxWaitTime = 15 #Seconds

export var waves = [
	[
		[0.0, ENEMIES.grunt],
		[2.0, ENEMIES.grunt],
		[4.0, ENEMIES.grunt],
		[6.0, ENEMIES.grunt],
		[8.0, ENEMIES.grunt],
		[10.0, ENEMIES.grunt],
		[12.0, ENEMIES.grunt],
	]
]

func can_place_tower():
	return Energy >= tower_energy_cost

func can_place_energy_factory():
	return Chips >= energy_factory_chips_cost
