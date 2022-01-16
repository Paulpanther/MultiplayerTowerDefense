extends Node

export var currentHealth = 100

#GAMESTATE
export var difficulty = 0

#BASE
export var baseHealth = 150

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
