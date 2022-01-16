extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const grunt = preload("res://Enemies/grunt/grunt.tscn")
const hover = preload("res://Enemies/hover/hover.tscn")
const runner = preload("res://Enemies/runner/runner.tscn")

var currentWave = 0 
var lastSpawn = -1
var levelState = STATE.start
var paths: Array = []
var lastPath = 0

enum STATE{
	start,
	wave,
	wait,
	end
}

func spawnEnemy(type):
	print("spawn " + str(type))
	lastPath = (lastPath + 1) % len(paths)
	var pfEnemy
	match type:
		Global.ENEMIES.grunt :
			pfEnemy = grunt.instance()
		Global.ENEMIES.hover:
			pfEnemy = hover.instance()
		Global.ENEMIES.runner:
			pfEnemy = runner.instance()
		_:
			pfEnemy = grunt.instance()
			
	paths[lastPath].add_child(pfEnemy)
	pass

func updateWave():
	var updated = false
	while not updated:
		if len(Global.waves[currentWave]) >lastSpawn + 1 and Global.waves[currentWave][lastSpawn + 1][0] <= Global.stateTimer:
			spawnEnemy(Global.waves[currentWave][lastSpawn + 1][1])
			lastSpawn += 1
		else:
			updated = true
	

# Called when the node enters the scene tree for the first time.
func _ready():
	var enemy_path = $enemy_path
	print("Loaded level " + self.name)
	
	paths = get_tree().get_nodes_in_group("enemy_paths")
	pass # Replace with function body.


func _physics_process(delta):
	
	Global.stateTimer += delta
	match levelState:
		STATE.start:
			if Global.stateTimer > Global.startDelay:
				levelState = STATE.wave
				Global.stateTimer = 0
		STATE.wave:
			updateWave()
			if len(Global.waves[currentWave]) - 1 <= lastSpawn:
				if len(Global.waves) - 1 <= currentWave:
					levelState = STATE.end
					print("end" + str(currentWave))
				else:
					if len(get_tree().get_nodes_in_group("enemy")) <= 0:
						lastSpawn = 0
						levelState = STATE.wait
						Global.stateTimer = 0
						currentWave += 1
						print("wait")
		STATE.wait:
			print(Global.stateTimer)
			if Global.maxWaitTime <= Global.stateTimer:
				Global.stateTimer = 0.0
				levelState = STATE.wave
			pass
		STATE.end:
			pass
