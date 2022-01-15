extends KinematicBody

export var speed = 10

#func _network_ready(is_source):
#	if is_source:
#		set_color(Color.from_hsv(rand_range(1, 360), 1, 1))
#		position = Vector2(rand_range(0, 600), rand_range(0, 400))
#	# same value on all clients now!
#	print(color)

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
	
	move_and_slide_with_snap(direction * speed, Vector3.DOWN, Vector3.UP)

