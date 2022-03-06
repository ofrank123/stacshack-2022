extends Node

#this will be global -- whole game can access this!
signal rooms_updated

#everytime we change a room state, we call the signal using these variables through setget
var room_states: = "" setget set_roomState

var roomsAndState := [0,0,0,0,0,0]

func set_roomState(roomData:String) -> void:
	var roomIndex = roomData[0]
	var roomState = roomData[1]
	room_states = roomData
	roomsAndState[int(roomIndex)] = int(roomState)
	print(roomsAndState)
	emit_signal("rooms_updated",room_states)
