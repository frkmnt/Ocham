extends Node


#==== Bootstrap ====#

func _ready():
	var network = NetworkedMultiplayerENet.new()
	network.create_server(4242, 2)
	get_tree().set_network_peer(network)

	network.connect("peer_connected", self, "_peer_connected")
	network.connect("peer_disconnected", self, "_peer_disconnected")


#==== Connection Management ====#

func _peer_connected(id):
	print("\nUser " + str(id) + " connected")
	print("Total Users:" + str(get_tree().get_network_connected_peers().size()))
  
func _peer_disconnected(id):
	print("\nUser " + str(id) + " disconnected")



#func _on_buttonSendData_pressed():
#	print("Sending data to client")
#	var textToSend = get_parent().get_node("textToSend").text
#	get_tree().multiplayer.send_bytes(textToSend.to_ascii())
