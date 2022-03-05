extends Node2D

onready var _network_client = get_node("./NetworkClient")
onready var _others = get_node("./Others")

var player_id = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	_network_client.connect("gamestate", self, "_on_gamestate");

func _on_gamestate(gamestate):
	print("Gamestate:", gamestate)
	for player in gamestate.players:
		var found = false
		for other in _others.get_children():
			if player.id == other.id:
				found = true
				other.position = Vector2(player.pos.x, player.pos.y)
		if !found && player.id != player_id:
			var new_other = load("res://Other.tscn").instance();
			new_other.id = player.id
			_others.add_child(new_other)
