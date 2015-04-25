
extends Button

func _ready():
	self.connect("pressed",self,"pressed_quit")
	
func pressed_quit():
	get_tree().quit()


