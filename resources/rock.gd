extends StaticBody
#Mask Tag 3

var capacity = 5
var available = true
var respawn_time = 5.0

var capacity_left = capacity
var respawn_timer

#remove later
var format_feedback_str = "Rocks left: %s."


func _ready():
	respawn_timer = get_tree().create_timer(0.0)
	
func hit(hand):
	if Input.is_action_just_pressed("mouse_click") and available:
		capacity_left -= 1
		
		#remove later
		var feedback_str = format_feedback_str % capacity_left
		print(feedback_str)
	
func respawn():
	available = true
	capacity_left = capacity
	show()
	get_node("CollisionShape").disabled = false
	
func despawn():
	hide()
	get_node("CollisionShape").disabled = true
	available = false
	if respawn_timer.time_left <= 0.0:
			respawn_timer = get_tree().create_timer(respawn_time)
			yield(respawn_timer, "timeout")
			respawn()

func _process(delta):
	if capacity_left == 0:
		despawn()
