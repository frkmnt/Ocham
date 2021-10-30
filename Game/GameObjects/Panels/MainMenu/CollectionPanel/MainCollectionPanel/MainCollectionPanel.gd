extends Control

#==== References ====#
onready var _parent = get_parent()
onready var _grid = $GridContainer

#==== Variables ====#
var _max_decks = 16


#==== Bootstrap ====#

func _ready():
	 load_starter_decks()

func load_starter_decks():
	load_deck_1()


func load_deck_1():
	var deck = CardLoader.create_default_deck_1()
	var deck_item = ObjectFactory.instance_deck_item()
	_grid.add_child(deck_item)
	deck_item.initialize(deck)
	deck_item.connect("on_deck_item_clicked", self, "on_deck_clicked")



#==== UI Interaction ====#

func on_deck_clicked(deck):
	_parent.on_mc_deck_clicked(deck)

func on_new_deck_button_clicked():
	var total_decks = _grid.get_child_count()
	if total_decks >= _max_decks:
		return
	var deck = CardLoader.create_new_deck()
	var deck_name = str("New Deck ", total_decks+1)
	var deck_description = "This is a new awesome deck you just created."
	deck.initialize_data(deck_name, deck_description)
	var deck_item = ObjectFactory.instance_deck_item()
	_grid.add_child(deck_item)
	deck_item.initialize(deck)
	deck_item.connect("on_deck_item_clicked", self, "on_deck_clicked")

func on_back_button_clicked():
	_parent.on_mc_back_button_clicked()


func _on_NewDeckButton_pressed():
	pass # Replace with function body.
