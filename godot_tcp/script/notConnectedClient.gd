
extends Panel

var debug = null

func _ready():
	
	debug = get_node("/root/Client").debug #Debug node
	debug.print_debug("Insert hostname:port and click connect")
	
