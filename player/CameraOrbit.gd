extends Spatial


var lookSensitivity : float = 35.0
var minLookAngle : float = -20.0
var maxLookAngle : float = 75.0

var isLeft : bool = true

var mouseDelta : Vector2 = Vector2()

onready var player = get_parent()
onready var hand = player.get_node("Hand")
onready var collisionIndicator = player.get_node("CollisionIndicator")
var collision_point

func get_collision_point():
	return collision_point

# Called when the node enters the scene tree for the first time.
func _ready():
	#Seems to reduce the sensitivity, maybe because of the small window
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	$Camera.current = player.is_network_master()


func _input(event):
	if not player.is_network_master():
		return
	
	if event is InputEventMouseMotion:
		mouseDelta = event.relative
		

func _process(delta):
	if not player.is_network_master():
		return
		
	var rot = Vector3(mouseDelta.y, mouseDelta.x, 0) * lookSensitivity * delta
	
	rotation_degrees.x += rot.x
	rotation_degrees.x = clamp(rotation_degrees.x, minLookAngle, maxLookAngle)
	
	hand.rotation_degrees.x += rot.x
	hand.rotation_degrees.x = clamp(hand.rotation_degrees.x, minLookAngle + 90, maxLookAngle + 90)
	#print(hand.rotation_degrees.x)
	
	player.rotation_degrees.y -= rot.y
	
	mouseDelta = Vector2()

	# TBD: Change perspective
	

	
	if Input.is_action_pressed("camera_left") and !isLeft:
		translate(Vector3(2, 0, 0))
		isLeft = true
	if Input.is_action_pressed("camera_right") and isLeft:
		translate(Vector3(-2, 0, 0))
		isLeft = false
		
	if $Camera/RayCast.is_colliding():
		collisionIndicator.show()
		collision_point = $Camera/RayCast.get_collision_point()
		collisionIndicator.global_transform.origin = collision_point
	else:
		collision_point = null
		collisionIndicator.hide()
	

	

