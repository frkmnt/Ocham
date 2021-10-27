extends Control

#==== References ====#
onready var _parent = get_parent()


#==== Bootstrap ====#

func _ready():
	pass # Replace with function body.



#==== UI Interaction ====#

func on_play_button_clicked():
	_parent.on_mp_play_button_clicked()

func on_collection_button_clicked():
	_parent.on_mp_collection_button_clicked()
