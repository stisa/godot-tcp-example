
extends Button

func _ready():
	
	self.connect("pressed",self,"disconnect_from_server")	
	
func disconnect_from_server():
	
		get_node("/root/Client").disconnect_from_server()
		get_node("/root/Client").debug.print_debug("Disconnecting...")
