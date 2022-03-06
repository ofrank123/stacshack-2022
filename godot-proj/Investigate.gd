extends Button

onready var root = get_node("/root/Root")

func _pressed() -> void:
	var roomStateStr = str(root.current_room) + "1"
	RoomsData.room_states = roomStateStr
	
func _process(delta):
	if (RoomsData.roomsAndState[root.current_room] > 0):
		self.disabled=true
	else:
		self.disabled = false
