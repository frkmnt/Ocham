extends Node2D


#==== Bootstrap ====#
func _ready():
	var window_size = OS.get_window_size()
	print(window_size)
	window_size = get_viewport().get_size()
	print(window_size)
	
	position.x = window_size.x 
	position.y = window_size.y / 2

