
extends Button

var editText = null

func _ready():
	
	self.connect("pressed",self,"send_to_server")
	# Reference to TextEdit
	editText = self.get_parent().get_node("TextEdit")

func send_to_server():
		
		var data = editText.get_text()
		get_node("/root/Client").send_to_server(data)
		