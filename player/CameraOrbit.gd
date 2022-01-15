extends Spatial


var lookSensitivity : float = 35.0
var minLookAngle : float = -20.0
var maxLookAngle : float = 75.0

var isLeft : bool = true

var mouseDelta : Vector2 = Vector2()

onready var player = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	#Seems to reduce the sensitivity, maybe because of the small window
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	
	if event is InputEventMouseMotion:
		mouseDelta = event.relative
		

func _process(delta):
	
	var rot = Vector3(mouseDelta.y, mouseDelta.x, 0) * lookSensitivity * delta
	
	rotation_degrees.x += rot.x
	rotation_degrees.x = clamp(rotation_degrees.x, minLookAngle, maxLookAngle)
	
	player.rotation_degrees.y -= rot.y
	
	mouseDelta = Vector2()

	# TBD: Change perspective
	"""
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("camera_left") and !isLeft:
		#global_translate(Vector3(1, 0, 0))
		isLeft = true
	if Input.is_action_pressed("camera_right") and isLeft:
		#global_translate(transform(Vector3(-1, 0, 0), )
		isLeft = false
"""
