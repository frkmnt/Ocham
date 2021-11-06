extends Node

#==== Properties ====#
var _name = "Deck"
var _description = "Placeholder Description"

#==== Cards ====#
var _deck_cards = {"all_active_cards": [], "all_growth_cards": []}


#==== Bootstrap ====#

func initialize_data(name, description):
	_name = name
	_description = description

func initialize_with_data(deck_data):
	var active_cards = _deck_cards.get("all_active_cards")
	var growth_cards = _deck_cards.get("all_growth_cards")
	var card_data_list
	for deck_type in deck_data.keys():
		card_data_list = deck_data.get(deck_type)
		_deck_cards[deck_type] = card_data_list
		if deck_type == "growth":
			for card_data in card_data_list:
				growth_cards.push_front(card_data)
		else:
			for card_data in card_data_list:
				active_cards.push_front(card_data)


#==== Card Management ====#

func add_card(card):
	_deck_cards[card._data._type].push(card)
	_deck_cards["all_cards"].push(card)


func get_cards_by_type(type):
	return _deck_cards[type]



#==== Game Logic ====#

func draw_active_card(): # on deck click
	var active_cards = _deck_cards.get("all_active_cards")
	var deck_size = active_cards.size()
	if deck_size == 0:
		return null # TODO add a game over signal
	var card_info
	var random_card_index = floor(rand_range(0, deck_size))
	card_info = active_cards[random_card_index]
	active_cards.remove(random_card_index)
	return card_info

func draw_growth_card(): # on deck click
	var growth_cards = _deck_cards.get("all_growth_cards")
	var deck_size = growth_cards.size()
	if deck_size == 0:
		return null # TODO add a game over signal
	var card_info
	var random_card_index = floor(rand_range(0, deck_size))
	card_info = growth_cards[random_card_index]
	growth_cards.remove(random_card_index)
	return card_info
