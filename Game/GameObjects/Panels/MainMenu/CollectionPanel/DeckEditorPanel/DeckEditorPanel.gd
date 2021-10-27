extends Control

#==== References ====#
onready var _parent = get_parent()

#==== Components ====#
onready var _card_grid = $CardGrid
onready var _accordion_container = $AccordionContainer
onready var _left_button = $LeftButton
onready var _right_button = $RightButton

#==== Variables ====#
const _cards_per_page = 8
var _cards = []
var _total_cards = 0
var _card_index = 0



#==== Bootstrap ====#

func initialize(card_id_list):
	add_cards_to_accordion(card_id_list)
	update_cards()



#==== Card Accordion ====#

func add_cards_to_accordion(card_id_list):
	var card_data = []
	for card_id in card_id_list:
		card_data.push_front(CardLoader.get_active_card_data(card_id))
	_accordion_container.add_cards(card_data)

func add_card_to_accordion(card_data):
	var new_card_data = CardLoader.get_active_card_data(card_data._id)
	_accordion_container.add_card(new_card_data)

#==== Card Grid ====#

func update_cards():
	# takes the cur card_index to determine what cards should be rendered
	_card_grid.remove_all_cards()
	var from = _card_index * _cards_per_page 
	var to = ((_card_index + 1) * _cards_per_page)
	
	var total_cards = CardLoader.get_total_cards()
	if to > total_cards:
		to = total_cards
	
	var card
	for idx in range(from, to):
		card = CardLoader.instance_active_card(idx)
		_card_grid.add_card(card)
	_card_grid.position_cards_correctly()

func on_card_click(card):
	add_card_to_accordion(card._data)




#==== UI Interaction ====#

func on_open():
	visible = true
	_card_index = 0
	_left_button.visible = false
	if get_total_pages() > 1:
		_right_button.visible = true

func on_back_button_clicked():
	_parent.on_de_back_button_clicked()
	_card_index = 0
	_card_grid.remove_all_cards()
	_accordion_container.clear_cards_from_accordions()
	_accordion_container.collapse_all_accordions()




#==== Arrow Buttons ====#

func on_left_arrow_clicked():
	print("left, ")
	if _card_index == 0:
		return
	elif _card_index == 1:
		_left_button.visible = false
	_right_button.visible = true
	_card_index -= 1
	update_cards()

func on_right_arrow_clicked():
	print("right, ")
	var total_pages = get_total_pages()
	if _card_index == total_pages-1:
		return
	elif _card_index == total_pages-2:
		_right_button.visible = false
	_left_button.visible = true
	_card_index += 1
	update_cards()




#==== Utils ====#
func get_total_pages():
	return ceil(float(CardLoader.get_total_cards()) / _cards_per_page)
