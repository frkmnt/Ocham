extends Control

#==== Class Comments ====#
# Aliases: mp -> main panel, mc -> main card collection, de -> deck editor

#==== References ====#
onready var _parent = get_parent()

#==== Components ====#
onready var _mp = $MainPanel
onready var _mc = $MainCollectionPanel
onready var _de = $DeckEditorPanel


#==== Bootstrap ====#

func _ready():
	pass


#==== Main Panel ====#

func on_mp_play_button_clicked():
	var player_deck = CardLoader.create_default_deck_1()
	var opponent_deck = CardLoader.create_default_deck_2()
	_parent.go_to_game(player_deck, opponent_deck)

func on_mp_collection_button_clicked():
	_mp.visible = false
	_mc.visible = true


#==== Main Collection ====#

func on_mc_deck_clicked(deck):
	_de.initialize(deck)
	_de.on_open()
	_mc.visible = false

func on_mc_back_button_clicked():
	_mc.visible = false
	_mp.visible = true

func get_current_deck():
	return _mc._grid.get_child(0)._deck


#==== Deck Editor ====#

func on_de_back_button_clicked():
	_de.visible = false
	_mc.visible = true





