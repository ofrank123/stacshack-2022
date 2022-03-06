extends Button

onready var root = get_node("/root/Root")
onready var timer = get_node("../Timer")
onready var player = get_parent()

func _pressed() -> void:
	var roomStateStr = str(root.current_room) + "1"
	RoomsData.room_states = roomStateStr
	#start player timer
	timer.wait_time = 5
	timer.start()
	player.is_busy = true
	player.last_executed_room = root.current_room
	
	
func _process(delta):
	#also check if user "is busy"
	if (RoomsData.roomsAndState[root.current_room] > 0 or player.is_busy):
		self.disabled=true
	elif (player.is_busy == false):
		self.disabled = false
