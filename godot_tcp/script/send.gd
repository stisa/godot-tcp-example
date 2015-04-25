
extends Button

var editText = null

func _ready():
	self.connect("pressed",self,"send_to_server")
	# Reference to a TextEdit
	editText = self.get_parent().get_child(5)

func send_to_server():
		var data = editText.get_text()
		get_parent().send_to_server(data)
		