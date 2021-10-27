extends Node

#==== Meta ====#
var _id = 1
var _card_name = ""
var _description = ""
var _rarity = 0
var _rarity_name = "Common"
var _type = 1
var _type_name = "Active"

#==== Stats ====#
var _cost = 1
var _value = 1
var _effect = 0



#==== Bootstrap ====#

func initialize(data_dict):
	_id = data_dict.id
	_card_name = data_dict.card_name
	_description = data_dict.description
	_rarity = data_dict.rarity
	_rarity_name = data_dict.rarity_name
	_type = data_dict.type
	_type_name = data_dict.type_name
	_cost = data_dict.cost
	_value = data_dict.value
	_effect = data_dict.effect
