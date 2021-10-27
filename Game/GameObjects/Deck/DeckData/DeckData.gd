extends Node

#==== Properties ====#
var _name = "Deck"
var _description = "Placeholder Description"

#==== Cards ====#
var _active_cards = []
var _growth_cards = [] 
var _fungi_cards = [] 
var _weather_cards = []


#==== Bootstrap ====#

func _ready():
	pass


#==== Card Management ====#

func add_card(card):
	match card._data._type:
		"active":
			_active_cards.push(card)
		"growth":
			_growth_cards.push(card)
		"fungi":
			_fungi_cards.push(card)
		"weather":
			_weather_cards.push(card)
