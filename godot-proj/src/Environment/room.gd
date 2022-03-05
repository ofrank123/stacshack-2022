extends Node2D

onready var area = get_node("./Area")
onready var root = get_node("/root/Root")

export var room_id := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	area.connect("body_entered", self, "_on_room_entered")

func _on_room_entered(_body):
	root.current_room = room_id
