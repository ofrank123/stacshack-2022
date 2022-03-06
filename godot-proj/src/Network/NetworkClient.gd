extends Node

# The URL we will connect to
export var websocket_url = "wss://sh318.host.cs.st-andrews.ac.uk/node"

# Our WebSocketClient instance
var _client = WebSocketClient.new()
onready var _root = get_node("..");
onready var _player = get_node("../Player")

signal gamestate(gamestate)

func handle_payload(payload):
	match payload.type:
		"connected":
			_root.player_id = payload.id
		"game-state":
			emit_signal("gamestate", payload.gameState)
		_:
			print("Received data: ", payload)

func send_message(message):
	_client.get_peer(1).put_packet(JSON.print(message).to_utf8())

func _ready():
	_client.connect("connection_closed", self, "_closed")
	_client.connect("connection_error", self, "_closed")
	_client.connect("connection_established", self, "_connected")
	_client.connect("data_received", self, "_on_data")

	_player.connect("moved", self, "_on_player_move")

	var err = _client.connect_to_url(websocket_url)
	if err != OK:
		print("Unable to connect")
		set_process(false)

func _on_player_move(pos: Vector2):
	if (_root.player_id):
		send_message({"type": "move", "id": _root.player_id, "pos": {"x": pos.x, "y": pos.y}})

func _closed(was_clean = false):
	print("Closed, clean: ", was_clean)
	set_process(false)

func _connected(proto = ""):
	print("Connected with protocol: ", proto)
	send_message({"type": "connect"});

func _on_data():
	var payload = JSON.parse(_client.get_peer(1).get_packet().get_string_from_utf8()).result
	handle_payload(payload)

func _send():
	_client.get_peer(1).put_packet(JSON.print({"type": "connect"}).to_utf8())

func _process(_delta):
	_client.poll()
	_client.get_peer(1).put_packet(JSON.print({"type": "poll"}).to_utf8())
