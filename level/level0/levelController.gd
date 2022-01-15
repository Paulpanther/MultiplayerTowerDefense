extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const grunt = preload("res://Enemies/grunt/grunt.tscn")

var currentWave = 0
var stateProgress = 0
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
	
	var pfEnemy = grunt.instance()
	
	paths[lastPath].add_child(pfEnemy)
	pass

func updateWave():
	var updated = false
	while not updated:
		if len(Global.waves[0]) >lastSpawn + 1 and Global.waves[0][lastSpawn + 1][0] <= stateProgress:
			spawnEnemy(Global.waves[0][lastSpawn + 1][1])
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
	stateProgress += delta
	match levelState:
		STATE.start:
			if Input.is_action_just_pressed("ui_focus_next"):
				levelState = STATE.wave
				stateProgress = 0
		STATE.wave:
			updateWave()
			if len(Global.waves[0]) - 1 <= lastSpawn:
				if len(Global.waves) - 1 <= currentWave:
					levelState = STATE.end
					print("end")
				else:
					levelState = STATE.wait
					stateProgress = 0
					currentWave += 1
					print("wait")
		STATE.wait:
			if Global.maxWaitTime <= stateProgress:
				levelState = STATE.wave
			pass
		STATE.end:
			pass
