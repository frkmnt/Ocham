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
var _cost = 1 # health
var _value = 1
var _effect = 0

#==== Meta Stats ====#
var _cur_latency = 1
var _cur_health = 1
var _cur_toughness = 1
var _effects_dict = {} # dict of effect_type_id : [effect_list]
var _attack_cooldown = false
var _has_attacked = false

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
	_cur_health = _cost
	_value = data_dict.value
	_cur_toughness = _value
	_effect = data_dict.effect
	_effect_description = data_dict.effect_description




#==== Events ====#

func on_turn_start():
	_attack_cooldown = false
	_has_attacked = false





#==== Value Manipulation ====#

func deal_damage(value):
	# TODO apply effects
	if value > 0:
		_cur_health -= value
		if _cur_health <= 0:
			_cur_health = 0
			_card._frame._animations.play("defeat")
			var _in_game_manager = get_tree().get_nodes_in_group("in_game_manager")[0]
			_in_game_manager.on_active_card_defeated_stage_1(_card)
		else:
			_card._frame._animations.play("slash")
		_card._frame.lose_cost(_cur_health)




func add_cost_to_card(value):
	_cur_health -= value
	if _cur_health <= 0:
		_card._container._parent.on_active_card_defeated(_card)

func add_value_to_card(value):
	_cur_toughness += value


func can_attack():
	var can_attack = true
	if _attack_cooldown or _has_attacked:
		can_attack = true
	return can_attack



