extends Node2D

var map_sprites = {
	"start": "res://src/Environment/start_room.tscn",
	"middle": "res://src/Environment/middle_room.tscn",
	"end": "res://src/Environment/end_room.tscn"
}

export var map = []
var players = 4
var roomMultiplier = 2

func generate_map(numRooms):
	map.append("start")
	for i in numRooms:
		map.append("middle")
	map.append("end")



func _ready():
	var numRooms = players * roomMultiplier
	self.generate_map(numRooms)
	print(map)


#func show_map(map_name):
#	if self.current_map != null:
#		#deletes current node
#		self.current_map.queue_free()
#	self.current_map = load(map_sprites[map_name]).instance()
#	self.current_map.z_index = -1
#	self.add_child(self.current_map)
