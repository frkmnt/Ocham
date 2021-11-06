extends Node2D

#==== Class Comments ====#
# Active cards are played in the top slots. They have a cost and
# an associated attack value. 

#== Components ==#
onready var _container = get_parent()

#== Components ==#
var _frame
var _data 
var _interaction_handler 




#==== Bootstrap ====#

func initialize(data_dict):
	initialize_components()
	_data.initialize(data_dict)
	_frame.initialize(data_dict)

func initialize_components():
	_frame = $Frame 
	_data = $Data
	_interaction_handler = $InteractionHandler



#==== Utils TODO MOVE TO INTERACTION MANAGER====#

func get_card_size():
	return Vector2(_frame.get_width() * scale.x, _frame.get_height() * scale.y)

func get_card_width():
	return _frame.get_width() * scale.x

func get_card_height():
	return _frame.get_height() * scale.y




#==== Update Values ====#

func set_new_text (new_text):
	_frame._description_label.text = new_text



#==== Logic ====#





#func start_card_back_animation():
#	_tween.interpolate_property(self,'modulate',
#			_pulse_values[0], _pulse_values[1], 2,
#			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#	_tween.start()
