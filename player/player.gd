extends KinematicBody

export var speed = 10

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

