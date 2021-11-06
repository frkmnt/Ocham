extends Node


#==== References ====#

onready var _parent = get_parent()


func on_click():
	_parent.on_turn_end_stage_0()
