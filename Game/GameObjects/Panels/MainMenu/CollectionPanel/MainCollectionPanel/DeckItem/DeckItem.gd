extends Control

#==== Signals ====#
signal on_deck_item_clicked

#==== Components ====#
onready var _deck_name = $DeckName
onready var _deck_description = $DeckDescription

#==== Variables ====#
var _deck


#==== Bootstrap ====#


func initialize(deck):
	_deck = deck
	_deck_name.text = deck._name
	_deck_description.text = deck._description


func on_click():
	emit_signal("on_deck_item_clicked", _deck)
