extends Node

#==== Meta ====#
var _id = 1
var _card_name = ""
var _description = ""
var _rarity = 0
var _rarity_name = "Common"
var _type = 1
var _type_name = "Active"
var _effect_description = ""

#==== Stats ====#
var _cost = 1
var _value = 1
var _effect = 0

#==== Meta Stats ====#
var _cur_cost = 1
var _cur_value = 1
var _cur_effect = 0
var _effects_dict = {} # dict of effect_type_id : [effect_list]


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
	_effect_description = data_dict.effect_description



#==== Value Manipulation ====#

func add_cost_to_card(value):
	_cur_cost += value

func add_value_to_card(value):
	_cur_value += value

