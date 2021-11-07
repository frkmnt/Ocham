extends Area2D

#==== Components ====#
onready var _shape = $CollisionShape2D
onready var _cardback = $Cardback
onready var _label = $CenterContainer/Label

#==== References ====#
var _card

#==== Variables ====#
var _size 
var _margin = 0.03



#==== Bootstrap ====#

func _ready():
	_size = _shape.shape.extents * 2
	resize_card_back()

func resize_card_back():
	var new_scale = _size / _cardback.texture.get_size()
	new_scale -= new_scale * _margin
	_cardback.scale = new_scale

func calculate_card_scale():
	return _cardback.scale



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
	interaction_handler.remove_card_from_slot()
	interaction_handler.set_card_on_slot(self)
	_card.global_position = prev_pos
	interaction_handler.flip_to_back("finish_flip_to_back")
	interaction_handler.play_fade_out(1.5, "")
	interaction_handler.interp_to_global_position(global_position, 0.75)
	interaction_handler._locked = true
	_label.text = str(int(_label.text) + 1)



#==== Card Interaction ====#

func on_card_click(_new_card):
	return

