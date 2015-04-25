
extends RichTextLabel

# This script is an helper to print debug values,connection status,etc.
# to a RichTextLabel

func _ready():
	pass

func print_debug(data):
	# Print the data
	self.add_text(data)
	# Separate every line of text
	self.newline()
	