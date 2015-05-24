
extends Node2D

var client = null
var wrapped_client = null
var debug = null
var connectedScn = null
var notConnectedScn = null

func _ready():
	
	client = StreamPeerTCP.new()
	debug = self.get_child(0).get_child(0) #Debug node
	connectedScn = load("res://scene/connected.xscn")
	notConnectedScn = load("res://scene/notConnected.xscn")
	
var count = 0
func _process(delta):
	
	#debug = self.get_child(0).get_child(0) # keep updating reference to debug
	
	# Check if client is connected and has data before attempting to read data
	if client.is_connected() && wrapped_client.get_available_packet_count() >0:
	
		debug.print_debug("Received: "+str(wrapped_client.get_var()))
	if client.get_status()==1: # if client is connecting
	
		count= count+delta
	if count>1: # if it took more than 1s to connect, error
	
		debug.print_debug("Stuck connecting, please press disconnect")
		client.disconnect() #interrupts connection to nothing
		set_process(false) # stop listening for packets

func update_debug_ref(debug_node):
	debug = debug_node
	
func connect_to_server(host,port):
	
	# If the client is not connected, connect
	if !client.is_connected():

		debug.print_debug("Connecting...")
		# Connect to server
		client.connect(host,port)
		#Wrap the StreamPeerTCP in a PacketPeerStream
		wrapped_client = PacketPeerStream.new()
		wrapped_client.set_stream_peer(client)
		change_scn(connectedScn) # move to connectedScn
		set_process(true) # start listening for packets
		
	else:
		debug.print_debug("Client already connected")
		
func send_to_server(data):
	
	# Check if client is connected before attempting to send data
	#debug = self.get_child(0).get_child(0)
	if client.is_connected():
	
		debug.print_debug("Sending: "+str(data))
		# Send data
		wrapped_client.put_var(data)

# function to change scene
func change_scn(scnTo):
	
	var instScn = scnTo.instance()
	self.get_child(0).queue_free() # remove old scene
	self.add_child(instScn) # add new scene
	#debug = self.get_child(0).get_child(0) # re reference debug node
	#print(debug)
	

func disconnect_from_server():
	
	client.disconnect()
	change_scn(notConnectedScn) # return to the initial scene