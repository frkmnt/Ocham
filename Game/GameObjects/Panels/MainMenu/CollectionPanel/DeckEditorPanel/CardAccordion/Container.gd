extends Panel

#==== Components ====#
onready var _accordion_container = $ScrollContainer/VBoxContainer
onready var _active_acc = $ScrollContainer/VBoxContainer/ActiveAccordion
onready var _growth_acc = $ScrollContainer/VBoxContainer/GrowthAccordion
onready var _fungi_acc = $ScrollContainer/VBoxContainer/FungiAccordion
onready var _weather_acc = $ScrollContainer/VBoxContainer/WeatherAccordion



#==== Bootstrap ====#

func initialize_deck(deck_info):
	var deck = deck_info.d_deck
	_active_acc.add_cards_to_accordion(deck.get("active"))
	_growth_acc.add_cards_to_accordion(deck.get("growth"))
	_fungi_acc.add_cards_to_accordion(deck.get("fungi"))
	_weather_acc.add_cards_to_accordion(deck.get("weather"))



#==== Card Management ====#

func add_active_cards(active_card_data):
	for card_data in active_card_data:
		_active_acc.add_card(card_data)

func add_growth_cards(growth_card_data):
	for card_data in growth_card_data:
		_growth_acc.add_card(card_data)

func add_fungi_cards(fungi_card_data):
	for card_data in fungi_card_data:
		_active_acc.add_card(card_data)

func add_weather_cards(weather_card_data):
	for card_data in weather_card_data:
		_active_acc.add_card(card_data)



func add_card(card):
	add_cards([card])

func add_cards(cards):
	for card_data in cards:
		match card_data.type_name:
			"Active":
				_active_acc.add_card(card_data)
			"Growth":
				_growth_acc.add_card(card_data)
			"Fungi":
				_fungi_acc.add_card(card_data)
			"Weather":
				_weather_acc.add_card(card_data)



#==== Accordion Management ====#

func clear_cards_from_accordions():
	for accordion in _accordion_container.get_children():
		accordion.clear_cards_from_accordion()

func collapse_all_accordions():
	for accordion in _accordion_container.get_children():
		accordion._content_panel.shrink_panel()
