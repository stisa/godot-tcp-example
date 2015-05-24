
extends Button

# Default values
var host = '127.0.0.1'
var port = 3456

var editText = null

func _ready():

	self.connect("pressed",self,"connect_to_server")	
	editText = self.get_parent().get_node("notConnectedTextEdit")
	
func connect_to_server():

	var host_port = editText.get_text() # Get the host and port from the user

	if host_port :	# check if something was entered

		host_port = host_port.split(":", false) # split host and port
		host = host_port[0]
		port = int(host_port[1])
		#print(host_port)
		# Connect to the specified server
		get_node("/root/Client").connect_to_server(host,port)
	else:

		get_node("/root/Client").debug.print_debug("Wrong format, should be host:port")
