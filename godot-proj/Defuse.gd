extends Button

onready var root = get_node("/root/Root")

func _pressed() -> void:
	var roomStateStr = str(root.current_room) + "3"
	RoomsData.room_states = roomStateStr
	
func _process(delta):
	# this plus the other people requirement
	if (RoomsData.roomsAndState[root.current_room] == 2):
		self.disabled= false
	else:
		self.disabled = true
