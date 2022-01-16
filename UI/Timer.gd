extends Label

func _process(delta):
	var timer = round(Global.startDelay - Global.stateTimer)
	if timer < 10 and timer >=0:
		timer = "0" + str(timer)
	else:
		timer = str(timer)
	text = "00:"+timer
