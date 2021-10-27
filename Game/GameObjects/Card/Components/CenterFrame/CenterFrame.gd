extends Node2D

#==== Components ====#
onready var _frame 
onready var _name_label 
onready var _description_label 
onready var _cost_label
onready var _value_label
onready var _card_glow

#==== Variables ====#
var card_name = "Card"
var description = ""
var rarity = 0
var rarity_name = ""
var cost = 1
var value = 1
var effect = 0
var effect_description = ""
var image_id = 0



#==== Bootstrap ====#

func initialize(data_dict):
	initialize_values(data_dict)
	initialize_components()


func initialize_values(data_dict):
	card_name = data_dict.card_name
	description = data_dict.description
	rarity = data_dict.rarity
	rarity_name = data_dict.rarity_name
	cost = data_dict.cost
	value = data_dict.value
	effect = data_dict.effect
	effect_description = data_dict.effect_description
	image_id = data_dict.image_id

func initialize_components():
	_frame = $Frame
	_name_label = $Frame/NameLabel
	_description_label = $Frame/DescriptionLabel
	_cost_label = $Frame/Cost/CostLabel
	_value_label = $Frame/ActiveCenterpieceCommon/Frame/ValueLabel
	_card_glow = $CardGlow
#	_name_label.text = card_name
	_description_label.text = effect_description
	_value_label.text = str(cost)
	_cost_label.text = str(value)



#==== Transform ====#

func get_width():
	return _frame.texture.get_width()

func get_height():
	return _frame.texture.get_height()



#==== Glow ====#

func apply_glow():
	_card_glow.apply_glow()

func cancel_glow():
	_card_glow.cancel_glow()
