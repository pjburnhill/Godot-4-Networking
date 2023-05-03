# multiplayer.gd
extends Node

var PORT = 4433
var REMOTE_IP
@onready var myUPNP = $uPNP

func _ready():
	# You can save bandwidth by disabling server relay and peer notifications.
	multiplayer.server_relay = false

	# Automatically start the server in headless mode.
	if DisplayServer.get_name() == "headless":
		print("Automatically starting dedicated server.")
		_on_host_pressed.call_deferred(PORT)

func start_game():
	# Hide the UI.
	$UI.hide()
	# Only change level on the server.
	# Clients will instantiate the level via the spawner.
	if multiplayer.is_server():
		change_level.call_deferred(load("res://Scenes/level.tscn"))

# Call this function deferred and only on the main authority (server).
func change_level(scene: PackedScene):
	# Remove old level if any.
	var level = $Level
	for c in level.get_children():
		level.remove_child(c)
		c.queue_free()
	# Add new level.
	level.add_child(scene.instantiate())

func set_up_upnp(port):
	# Set up uPNP
	var upnp = myUPNP.set_upnp_mapping(port, 'Godot_uPNP')
	
	# Check uPNP results
	print('UDP Mapped: ', upnp.map_result_udp == UPNP.UPNP_RESULT_SUCCESS)
	print('TCP Mapped: ', upnp.map_result_tcp == UPNP.UPNP_RESULT_SUCCESS)
	if upnp.both_ports_mapped:
		print('Both UDP and TCP ports mapped.')
		print('External IP: ', upnp.external_ip)
		return true

func _on_host_pressed():
	if not set_up_upnp(PORT):
		OS.alert("Unable to setup uPNP port forwarding.")
		return
	# Start as server.
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer server.")
		return
	multiplayer.multiplayer_peer = peer
	start_game()

func _on_connect_pressed():
	# Start as client.
	var REMOTE_IP : String = $UI/Net/Options/IP_Container/Remote.text
	if REMOTE_IP == "":
		OS.alert("Need a remote to connect to.")
		return
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(REMOTE_IP, PORT)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer client.")
		return
	multiplayer.multiplayer_peer = peer
	start_game()

func _on_port_text_changed(new_port):
	PORT = int(new_port)

func _on_remote_text_changed(new_ip):
	REMOTE_IP = new_ip
