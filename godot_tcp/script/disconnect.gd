
extends Button



func _ready():
	self.connect("pressed",self,"disconnect_from_server")	
	
func disconnect_from_server():
		get_parent().debug.print_debug("Disconnecting...")
		get_parent().disconnect_from_server()

