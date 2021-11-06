extends Node

#==== References ====#
onready var _card = get_parent()

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
var _cur_latency = 1
var _cur_health = 1
var _cur_mana = 1
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
	_cur_latency = _cost
	_cur_health = _cost
	_value = data_dict.value
	_cur_mana = _value
	_effect = data_dict.effect
	_effect_description = data_dict.effect_description



#==== Value Manipulation ====#

func add_latency_to_card(value):
	_cur_latency += value

func add_health_to_card(value):
	_cur_health += value
	if _cur_health <= 0:
		_card._container._parent.on_growth_card_defeated(_card)



func deal_damage(value):
	# TODO apply effects
	if value > 0:
		_cur_health -= value
		if _cur_health <= 0:
			var in_game_manager = get_tree().get_nodes_in_group("in_game_manager")[0]
			in_game_manager.on_active_card_defeated(_card)
		_card._frame._animations.play("slash")


func add_mana_to_card(value):
	_cur_mana += value


func add_cost_to_card(value):
	add_latency_to_card(value)
	add_health_to_card(value)

func add_value_to_card(value):
	_cur_mana += value



#==== Growth Logic ====#

func get_mana_from_card():
	var mana = 0
	if _cur_latency <= 0:
		mana = _cur_mana
	return mana


#==== Animation ====#

func play_mana_anim():
	_card._frame._animations.play("mana")





