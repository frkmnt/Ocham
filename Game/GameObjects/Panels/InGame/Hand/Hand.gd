extends Node2D

#==== Comments ====#
# TODO add the cards to the list and refactor all the get_child calls

#==== References ====#
onready var _parent = get_parent()

#==== Logic Variables ====#
var _card_list = [] 

#==== UI Variables ====#
export var _width = 1000
export var _height = 600
export var _overlap_h_percentage = 0.15 # % of card width
export var _anim_dur = 0.5 # % of card width

var _desired_scale = Vector2(1.0, 1.0)
var _overlap_h = 0 # in world units



#==== Bootstrap ====#

func _ready():
	return

func initialize_card_size(max_hand_size):
	var desired_card_size = _width / max_hand_size
	var scale_value = desired_card_size / CardManager._card_size.x
	_desired_scale = Vector2(scale_value, scale_value)
	_overlap_h = CardManager._card_size.x * _overlap_h_percentage * _desired_scale.x

func initialize_with_deck(deck):
	for card in deck._deck_cards["all_cards"]:
		pass


#==== Card Logic ====#

func add_card(card):
	_card_list.append(card)
	add_child(card)
	card._interaction_handler.scale_card(_desired_scale)

func add_card_from_deck(card):
	_card_list.append(card)
	add_child(card)

func remove_all_cards():
	pass

func remove_card(card):
	var idx = _card_list.find(card)
	_card_list.remove(idx)

func remove_card_by_idx(idx):
	_card_list.remove(idx)


#==== Card Interaction ====#

func on_card_click(_card):
	return

func set_card_on_card_slot(card):
	card._interaction_handler._locked = true
	remove_child(card)
	position_cards_correctly_interp()




#==== Position Cards ====#

func position_cards_correctly_interp():
	var h_overlap = get_horizontal_overlap()
	position_cards_interp(h_overlap)

func get_horizontal_overlap():
	var t_card_width = get_total_card_width()
	var overlap_size = get_total_size_with_h_overlap(t_card_width)
	return overlap_size

func get_total_card_width():
	var total_width = 0
	for card in get_children():
		total_width += card.get_card_width()
	return total_width

func get_total_size_with_h_overlap(total_card_width):
	var tc = get_child_count()
	total_card_width -= _overlap_h * (tc - 1)
	return total_card_width



func get_correct_hscale(overlap_size):
	return _width / overlap_size



#==== Transform ====#

func position_cards_interp(overlap_size):
	var total_cards = get_child_count()
	if total_cards == 0:
		return
	else:
		var i = 0
		var card_width = get_child(0).get_card_width()
		var leftover_space = _width - overlap_size
		var start_x = - (_width / 2) + (leftover_space / 2) + (card_width / 2)
		var new_pos = Vector2(0,0)
		var interaction_handler
		for card in get_children():
			interaction_handler = card._interaction_handler
			new_pos.x = start_x + (card_width * i) - (_overlap_h * (i-1)) 
			interaction_handler.interp_to_position(new_pos, _anim_dur)
			interaction_handler._order = i
			interaction_handler._original_pos = new_pos
			card.z_index = i
			i += 1
