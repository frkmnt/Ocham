extends Node2D

#==== Class Comments ====#
# Active cards are played in the top slots. They have a cost and
# an associated attack value. 

#== Components ==#
onready var _container = get_parent()

#== Components ==#
onready var _frame = $ActiveFrame 
onready var _card_frame = $ActiveFrame/Frame
onready var _description_label = $ActiveFrame/Frame/DescriptionFrame/DescriptionLabel
onready var _common = $CollisionHandler
onready var _data = $CardCommon/Data

#== Variables ==#
var _cost = 0
var _power = 0
var _effect = ""



#==== Bootstrap ====#

func _ready():
	pass


#==== Utils ====#

func get_card_size():
	return Vector2(_card_frame.texture.get_width() * scale.x, _card_frame.texture.get_height() * scale.y)

func get_card_width():
	return _card_frame.texture.get_width() * scale.x

func get_card_height():
	return _card_frame.texture.get_height() * scale.y




#==== Update Values ====#

func set_new_text (new_text):
	_description_label.text = new_text



#==== Logic ====#





#func start_card_back_animation():
#	_tween.interpolate_property(self,'modulate',
#			_pulse_values[0], _pulse_values[1], 2,
#			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#	_tween.start()
