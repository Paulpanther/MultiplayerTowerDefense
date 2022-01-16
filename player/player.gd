extends KinematicBody

export var speed = 10
export var melee_damage = 1
export var melee_timeout = 800

onready var camera = $CameraOrbital

var last_melee = OS.get_system_time_msecs()

func _physics_process(delta):
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_forward"):
		direction.z += 1
	if Input.is_action_pressed("move_backward"):
		direction.z -= 1
	if Input.is_action_pressed("move_left"):
		direction.x += 1
	if Input.is_action_pressed("move_right"):
		direction.x -= 1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
	
	if is_on_floor():
		direction = transform.basis.z * direction.z + transform.basis.x * direction.x
	else:
		direction = transform.basis.z * direction.z + transform.basis.x * direction.x + Vector3(0, -.6, 0)
	
	move_and_slide(direction * speed, Vector3.UP)
	_process_melee()

func take_chip():
	Global.rpc("add_chips", 1)

func _process_melee():
	if camera.get_collision_group() == "enemy_collider":
		var enemy = camera.get_collider().get_parent()
		
		if Input.is_action_pressed("melee"):
			var time = OS.get_system_time_msecs()
			if time - last_melee > melee_timeout:
				enemy.take_damage(melee_damage)
				last_melee = time

