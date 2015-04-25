
extends Panel

var client = null
var wrapped_client = null
var debug = null

func _ready():
	client = StreamPeerTCP.new()
	debug = self.get_child(0) #Debug node
	
var count = 0
func _process(delta):
	# Check if client is connected and has data before attempting to read data
	if client.is_connected() && wrapped_client.get_available_packet_count() >0:
		debug.print_debug("Received: "+str(wrapped_client.get_var()))
	if client.get_status()==1:
		count= count+delta
	if count>1:
		debug.print_debug("Stuck connecting, please press disconnect")
		set_process(false)
	
func connect_to_server(host,port):
	# If the client is not connected, connect
	if !client.is_connected():
		debug.print_debug("Connecting...")
		# Connect to server
		client.connect(host,port)
		#Wrap the StreamPeerTCP in a PacketPeerStream
		wrapped_client = PacketPeerStream.new()
		wrapped_client.set_stream_peer(client)
		set_process(true)
	else:
		debug.print_debug("Client already connected")
		
func send_to_server(data):
	# Check if client is connected before attempting to send data
	if client.is_connected():
		debug.print_debug("Sending: "+str(data))
		# Send data
		wrapped_client.put_var(data)

func disconnect_from_server():
	client.disconnect()