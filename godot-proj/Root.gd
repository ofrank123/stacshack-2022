extends Node2D

onready var _network_client = get_node("./NetworkClient")
onready var _others = get_node("./Others")

const GameOverScreen = preload("res://src/UI/GameOverScreen.tscn")
const Player = preload("res://Player.tscn")

var player_id = ""
var current_room = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_network_client.connect("gamestate", self, "_on_gamestate");
	var player = get_node("Player")
	player.connect("player_defused_correctly",self,"handle_player_win")

func _on_gamestate(gamestate):
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

func handle_player_win():
	var game_over = GameOverScreen.instance()
	add_child(game_over)
	game_over.set_title(true)
	get_tree().paused = true

func handle_player_lose():
	var game_over = GameOverScreen.instance()
	add_child(game_over)
	game_over.set_title(false)
	get_tree().paused = true

#func _process(_delta):
#	print(current_room)

func _on_Timer_timeout() -> void:
	print("Too slow!")
	handle_player_lose()
