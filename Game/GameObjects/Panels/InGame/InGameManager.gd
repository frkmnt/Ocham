extends Node

#==== Components ====#
onready var _play_area = $PlayArea
onready var _player_hand = $PlayerHand

#==== Settings ====#
var _hand_start_size = 5
var _hand_max_size = 10




#==== Bootstrap ====#

func _ready():
	randomize()
	print(CardManager._card_size)

func initialize(deck):
	draw_initial_cards(deck)

#func initialize_decks(deck):
#	_player_hand.initialize_with_deck(deck)

func draw_initial_cards(deck):
	var cards_to_draw = _hand_start_size
	var card_data
	var card
	while cards_to_draw > 0:
		card_data = deck.draw_active_card()
		card = create_new_card(card_data)
		_player_hand.add_card(card)
		cards_to_draw-=1
	_player_hand.position_cards_correctly()


func create_new_card(card_data):
	var card
	match card_data.type_name:
		"Active":
			card = CardLoader.instance_active_card_with_data(card_data)
		"Growth":
			card = CardLoader.instance_growth_card_with_data(card_data)
		"Fungi":
			card = CardLoader.instance_fungi_card_with_data(card_data)
		"Weather":
			card = CardLoader.instance_weather_card_with_data(card_data)
	return card


