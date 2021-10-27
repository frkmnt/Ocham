extends Control

#==== Signals ====#
signal on_deck_item_clicked

#==== Components ====#
onready var _deck_name = $DeckName
onready var _deck_description = $DeckDescription

#==== Variables ====#
var _deck


#==== Bootstrap ====#


func initialize(name, description, deck):
	_deck_name.text = name
	_deck_description.text = description
	_deck = deck


func on_click():
	emit_signal("on_deck_item_clicked", self)
