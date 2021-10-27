extends Node

#==== Comments ====#
# TODO add the cards to the list and refactor all the get_child calls


#==== Logic Variables ====#
var _card_list = [] 



#==== UI Variables ====#
export var _width = 0
export var _height = 0

export var _overlap_h = 0.3 # % of card width



#==== Bootstrap ====#

func _ready():
	if get_child_count() > 0:
		position_cards_correctly()



#==== Card Logic ====#

func add_card(card):
	_card_list.append(card)

func add_card_list(card_list):
	pass

func remove_card(index):
	pass

func remove_all_cards():
	pass



#==== Signal Binding ====#

func apply_hover_signal_to_card():
	pass



#==== Position Cards ====#

func position_cards_correctly():
	position_cards_horizontally()
#	position_cards_vertically()

func position_cards_horizontally():
	var t_card_width = get_total_card_width()
	var overlap_size = get_total_size_with_h_overlap(t_card_width)
	if overlap_size > _width:
		var new_scale = get_correct_hscale(overlap_size)
		apply_scale_to_cards(new_scale)
		overlap_size *= new_scale
	position_cards(overlap_size)

func get_total_card_width():
	var total_width = 0
	var card_size = CardManager._card_size
	for card in get_children():
		total_width += card_size.x
	return total_width

func get_h_overlap_size():
	return CardManager._card_size.x * _overlap_h

func get_total_size_with_h_overlap(total_card_width):
	var tc = get_child_count()
	total_card_width -= get_h_overlap_size() * (tc - 1)
	return total_card_width

func get_correct_hscale(overlap_size):
	return _width / overlap_size





#==== Transform ====#

func apply_scale_to_cards(new_scale):
	for card in get_children():
		card._common.scale_card(Vector2(new_scale, new_scale))

func position_cards(overlap_size):
	var i = 0
	var start_x = - (_width / 2)
	var card_size = CardManager._card_size
		
	for card in get_children():
		print("posing")
		card.position.x = start_x + (overlap_size * (i-1)) + (card_size.x / 2)
		card._common._order = i
		card.z_index = i
		i += 1
