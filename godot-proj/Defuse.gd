extends Button

onready var root = get_node("/root/Root")
onready var timer = get_node("../Timer")
onready var player = get_parent()

func _pressed() -> void:
	var roomStateStr = str(root.current_room) + "3"
	RoomsData.room_states = roomStateStr
	timer.wait_time = 10
	timer.start()
	player.is_busy = true
	player.last_executed_room = root.current_room
	
func _process(delta):
	# this plus the other people requirement
	if (RoomsData.roomsAndState[root.current_room] == 2 and player.is_busy == false):
		self.disabled= false
	elif (player.is_busy):
		self.disabled = true
