extends Area2D

#==== Components ====#
onready var _shape = $CollisionShape2D
onready var _sprite = $Sprite

#==== References ====#
var _card = null

#==== Settings ====#
export var _is_playable_slot = false
export var _is_attackable_growth_slot = false
export var _is_attackable_active_slot = false

#==== Variables ====#
var _size 
var _margin = 0.03
export var _idx = 0


#==== Bootstrap ====#

func _ready():
	_size = _sprite.texture.get_size()


#==== Card Management ====#

func set_card_on_slot_from_hand(card):
	_card = card
	var interaction_handler = _card._interaction_handler
	var prev_pos = _card.global_position
	interaction_handler.remove_card_from_slot()
	interaction_handler.set_card_on_slot(self)
	_card.global_position = prev_pos
	
	var new_scale = _size / _card.get_card_size()
	new_scale -= new_scale * _margin
	new_scale *= _card.scale
	interaction_handler.scale_interp(new_scale)
	
	interaction_handler.interp_to_global_position(global_position, 0.5)
	interaction_handler._locked = true
	if int(_card._data._type) == int(1):
		interaction_handler._can_target = true


func set_card_on_slot_from_opponent_hand(card):
	_card = card
	var interaction_handler = _card._interaction_handler
	var prev_pos = _card.global_position
	interaction_handler.remove_card_from_slot()
	interaction_handler.set_card_on_slot(self)
	_card.global_position = prev_pos
	
	var new_scale = _size / _card.get_card_size()
	new_scale -= new_scale * _margin
	new_scale *= _card.scale
#	interaction_handler.scale_interp(new_scale)
	
	interaction_handler.interp_to_global_position(global_position, 0.5)
	interaction_handler.flip_to_front("finish_flip_to_front")
	interaction_handler._flip_scale = new_scale
	interaction_handler._locked = true
	if str(_card._data._type) == str(1):
		interaction_handler._can_target = true


func set_card_on_slot_from_deck(card, start_pos, start_scale):
	add_child(card)
	_card = card
	var interaction_handler = _card._interaction_handler
	card.global_position = start_pos
	card.scale = start_scale
	
	var new_scale = _size / _card.get_card_size()
	new_scale -= new_scale * _margin
	new_scale *= _card.scale
	interaction_handler.scale_interp(new_scale)
	
	interaction_handler.interp_to_global_position(global_position, 0.5)
	interaction_handler._locked = true
	interaction_handler.set_flipped(true)


func remove_card(card):
	remove_child(_card)
	_card = null


#==== Card Interaction ====#

func on_card_click(_new_card):
	return





