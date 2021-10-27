extends Node

#==== References ====#
onready var _parent = get_parent()

#==== Properties ====#
export var _direction = "left" # left or right



#==== Interaction ====#
func on_click():
	if _direction == "left":
		_parent.on_left_arrow_clicked()
	else:
		_parent.on_right_arrow_clicked()


