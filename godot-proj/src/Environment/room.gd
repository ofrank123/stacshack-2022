extends Node2D

onready var area = get_node("./Area")
onready var root = get_node("/root/Root")

export var room_id := 0

# 0 - uninvestigated, 1 - investigating, 2 - investigated, 3 - defusing , 4 - defusing (failed)
export var room_state := 0

#to do: generated for firs time, set likeliness
export var room_likeliness := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	area.connect("body_entered", self, "_on_room_entered")

func _on_room_entered(_body):
	root.current_room = room_id
