
extends Button

# Hardcoded because I'm lazy, sorry
var host = '192.168.1.6'
var port = 3456

func _ready():
	self.connect("pressed",self,"connect_to_server")	
	
func connect_to_server():
	# Connect to the specified server
	get_parent().connect_to_server(host,port)

