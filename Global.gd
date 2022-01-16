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
	runner,
	hover
}

export(ENEMIES) var enemies = ENEMIES.grunt

#LEVELS
export var startDelay = 5
export var stateTimer = 0
export var maxWaitTime = 3 #Seconds

export var waves = [
	[
		[0.0, ENEMIES.grunt],
		[2.0, ENEMIES.grunt],
		[4.0, ENEMIES.grunt],
		[6.0, ENEMIES.grunt],
		[8.0, ENEMIES.grunt],
		[10.0, ENEMIES.grunt],
		[12.0, ENEMIES.grunt]
	],
	[
		[0.0, ENEMIES.grunt],
		[1.0, ENEMIES.grunt],
		[2.0, ENEMIES.grunt],
		[3.0, ENEMIES.grunt],
		[4.0, ENEMIES.grunt],
		[5.0, ENEMIES.grunt],
		[6.0, ENEMIES.grunt],
		[7.0, ENEMIES.grunt],
		[8.0, ENEMIES.grunt],
		[9.0, ENEMIES.grunt],
		[10.0, ENEMIES.grunt],
		[11.0, ENEMIES.grunt],
		[12.0, ENEMIES.grunt],
		[13.0, ENEMIES.grunt],
		[13.0, ENEMIES.runner]
	],
	[
		[0.0, ENEMIES.grunt],
		[1.0, ENEMIES.grunt],
		[2.0, ENEMIES.grunt],
		[3.0, ENEMIES.grunt],
		[3.5, ENEMIES.hover],
		[4.0, ENEMIES.grunt],
		[5.0, ENEMIES.grunt],
		[6.0, ENEMIES.grunt],
		[7.0, ENEMIES.grunt],
		[8.0, ENEMIES.grunt],
		[9.0, ENEMIES.grunt],
		[10.0, ENEMIES.grunt],
		[11.0, ENEMIES.grunt],
		[12.0, ENEMIES.grunt],
		[13.0, ENEMIES.grunt]
	],
	[
		[0.0, ENEMIES.grunt],
		[1.0, ENEMIES.grunt],
		[2.0, ENEMIES.grunt],
		[3.0, ENEMIES.grunt],
		[3.5, ENEMIES.hover],
		[4.0, ENEMIES.grunt],
		[5.0, ENEMIES.grunt],
		[6.0, ENEMIES.grunt],
		[7.0, ENEMIES.grunt],
		[8.0, ENEMIES.grunt],
		[9.0, ENEMIES.grunt],
		[10.0, ENEMIES.grunt],
		[11.0, ENEMIES.grunt],
		[12.0, ENEMIES.grunt],
		[13.0, ENEMIES.grunt],
		[14.0, ENEMIES.grunt],
		[15.0, ENEMIES.grunt],
		[16.0, ENEMIES.grunt],
		[17.0, ENEMIES.grunt],
		[17.5, ENEMIES.hover],
		[18.0, ENEMIES.grunt],
		[19.0, ENEMIES.grunt],
		[20.0, ENEMIES.grunt],
		[21.0, ENEMIES.grunt],
		[22.0, ENEMIES.grunt],
		[23.0, ENEMIES.grunt],
		[24.0, ENEMIES.grunt],
		[25.0, ENEMIES.grunt],
		[26.0, ENEMIES.grunt],
		[27.0, ENEMIES.grunt]
	],
	[
		[0.0, ENEMIES.hover],
		[5.0, ENEMIES.hover],
		[10.0, ENEMIES.hover],
		[15.0, ENEMIES.hover],
		[20.0, ENEMIES.hover],
	],
	[
		[0.0, ENEMIES.runner],
		[0.1, ENEMIES.runner],
		[0.2, ENEMIES.runner],
		[0.3, ENEMIES.runner],
		[0.4, ENEMIES.runner],
		[0.5, ENEMIES.runner],
		[0.6, ENEMIES.runner],
		[0.7, ENEMIES.runner],
		[0.8, ENEMIES.runner],
		[0.9, ENEMIES.runner],
		[1.0, ENEMIES.runner],
		[1.1, ENEMIES.runner],
		[1.2, ENEMIES.runner],
		[1.3, ENEMIES.runner],
		[1.4, ENEMIES.runner],
		[1.5, ENEMIES.runner],
		[1.6, ENEMIES.runner],
		[1.7, ENEMIES.runner],
		[1.8, ENEMIES.runner],
		[1.9, ENEMIES.runner],
	],
	[
		[0.0, ENEMIES.grunt],
		[0.1, ENEMIES.grunt],
		[0.2, ENEMIES.grunt],
		[0.3, ENEMIES.grunt],
		[0.4, ENEMIES.grunt],
		[0.5, ENEMIES.grunt],
		[0.6, ENEMIES.grunt],
		[0.7, ENEMIES.grunt],
		[0.8, ENEMIES.grunt],
		[0.9, ENEMIES.grunt],
		[1.0, ENEMIES.grunt],
		[1.1, ENEMIES.grunt],
		[1.2, ENEMIES.grunt],
		[1.3, ENEMIES.grunt],
		[1.4, ENEMIES.grunt],
		[1.5, ENEMIES.grunt],
		[1.6, ENEMIES.grunt],
		[1.7, ENEMIES.grunt],
		[1.8, ENEMIES.grunt],
		[1.9, ENEMIES.grunt],
	]
]

func can_place_tower():
	return Energy >= tower_energy_cost

func can_place_energy_factory():
	return Chips >= energy_factory_chips_cost
