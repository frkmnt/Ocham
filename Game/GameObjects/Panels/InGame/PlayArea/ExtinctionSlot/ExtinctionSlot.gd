extends Area2D

#==== Components ====#
onready var _cardback = $Cardback
onready var _label = $CenterContainer/Label

#==== References ====#
var _card

#==== Variables ====#
var _size 
var _margin = 0.03



#==== Card Management ====#

func update_total_cards(total_cards):
	_label.text = str(total_cards)

func set_cardback_visibility(visibility):
	_cardback.visible = visibility



#==== Card Management ====#

func set_card_on_slot_from_board(card):
	_card = card
	var interaction_handler = _card._interaction_handler
	var prev_pos = _card.global_position
	interaction_handler.set_on_card_slot()
	_card.get_parent().remove_child(_card)
	add_child(_card)
	_card.global_position = prev_pos
	interaction_handler.flip_to_back("finish_flip_to_back")
	interaction_handler.interp_to_global_position(global_position, 0.75)
	interaction_handler._locked = true
	_label.text = str(int(_label.text) + 1)



#==== Card Interaction ====#

func on_card_click(_new_card):
	return

