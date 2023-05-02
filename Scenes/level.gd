# level.gd
extends Node

func _ready():
	# We only need to spawn players on the server.
	if not multiplayer.is_server():
		return

	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(del_player)

	# Spawn already connected players.
	for id in multiplayer.get_peers():
		add_player(id)

	# Spawn the local player unless this is a dedicated server export.
	if not OS.has_feature("dedicated_server"):
		add_player(1)


func _exit_tree():
	if not multiplayer.is_server():
		return
	multiplayer.peer_connected.disconnect(add_player)
	multiplayer.peer_disconnected.disconnect(del_player)


func add_player(id: int):
	var character = preload("res://Player/player.tscn").instantiate()
	# Set player id.
	character.player_id = id
	# Randomize character position.
	randomize()
	character.position = Vector2(randf_range(320.0, 960.0), 100)
	character.name = str(id)
	$Players.add_child(character, true)


func del_player(id: int):
	if not $Players.has_node(str(id)):
		return
	$Players.get_node(str(id)).queue_free()
