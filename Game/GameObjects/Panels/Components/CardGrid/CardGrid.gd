extends Node

#==== Comments ====#
# TODO add the cards to the list and refactor all the get_child calls

#==== References ====#
onready var _parent = get_parent()

#==== Logic Variables ====#
var _card_list = [] 



#==== UI Variables ====#
export var _columns = 4
export var _rows = 2

export var _width = 0
export var _height = 0

export var _min_h_gap = 0
export var _min_v_gap = 0.05



#==== Bootstrap ====#

func _ready():
	if get_child_count() > 0:
		position_cards_correctly()


#==== Card Logic ====#

func add_card(card):
	_card_list.append(card)
	add_child(card)

func add_card_list(card_list):
	pass

func remove_card(index):
	pass

func remove_all_cards():
	_card_list = []
	for card in get_children():
		remove_child(card)
		card.queue_free()


#==== Card Interaction ====#

func on_card_click(card):
	_parent.on_card_click(card)


#==== Position Cards ====#

func position_cards_correctly():
	position_cards_vertically()
	position_cards_horizontally()
	position_cards()


func position_cards_vertically():
	var t_card_height = get_total_card_height()
	var gap_size = get_vgap_size(t_card_height)
	var min_gap_size = get_min_vgap_size()
	var new_scale = get_child(0).scale.y
	if gap_size < min_gap_size:
		new_scale = get_correct_vscale(t_card_height, min_gap_size)
		gap_size = min_gap_size
	apply_scale_to_cards(new_scale)

func position_cards_horizontally():
	var t_card_width = get_total_card_width()
	var gap_size = get_hgap_size(t_card_width)
	var min_gap_size = get_min_hgap_size()
	
	var new_scale = get_child(0).scale.x
	if gap_size < min_gap_size:
		new_scale *= get_correct_hscale(t_card_width, min_gap_size)
		gap_size = min_gap_size
	apply_scale_to_cards(new_scale)


func get_total_card_width():
	var cc = get_child_count()
	if cc > _columns:
		cc = _columns
	var total_width = 0
	for i in range(0, cc):
		total_width += get_child(i).get_card_width()
	return total_width

func get_total_card_height():
	var cc = get_child_count()
	var total_height = 0
	if cc > _columns:
		total_height = _rows * get_child(0).get_card_height()
	else:
		total_height = get_child(0).get_card_height()
	return total_height


func get_hgap_size(total_card_width):
	var h_gap
	if _columns - 1 == 0:
		h_gap = 0
	else:
		h_gap = (_width - total_card_width) / (_columns - 1)
	return h_gap

func get_vgap_size(total_card_height):
	var v_gap
	if _rows - 1 == 0:
		v_gap = 0
	else:
		v_gap = (_height - total_card_height) / (_rows - 1)
	return v_gap


func get_min_hgap_size():
	return _min_h_gap * _width

func get_min_vgap_size():
	return _min_v_gap * _height


func get_correct_hscale(total_card_width, min_gap_size):
	var cc = get_child_count()
	var total_min_gap_width = min_gap_size * (cc - 1)
	var usable_w = _width - total_min_gap_width
	return usable_w / total_card_width

func get_correct_vscale(total_card_height, min_gap_size):
	var cc = get_child_count()
	var total_min_gap_height = min_gap_size * (floor((cc - 1 ) / _columns))
	var usable_h = _height - total_min_gap_height
	return usable_h / total_card_height


func apply_scale_to_cards(new_scale):
	for card in get_children():
		card._interaction_handler.scale_card(Vector2(new_scale, new_scale))



func position_cards():
	var i = 0
	var x_idx = 0
	var y_idx = 0
	var card_w = 0
	var card_h = 0
	var hgap = get_hgap_size(get_total_card_width())
	var vgap = get_vgap_size(get_total_card_height())
		
	for card in get_children():
		x_idx = i % _columns
		card_w = card.get_card_width()
		card.position.x = (x_idx * card_w) + (card_w / 2) + (x_idx * hgap)
		y_idx = floor(i / _columns)
		card_h = card.get_card_height()
		card.position.y = (y_idx * card_h) + (card_h / 2) + (y_idx * vgap)
		card._interaction_handler._order = i
		card.z_index = i
		i += 1


