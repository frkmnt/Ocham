extends Control

#==== References ====#
onready var _parent = get_parent()
onready var _grid = $GridContainer

#==== Variables ====#
var _max_decks = 16


#==== Bootstrap ====#

func _ready():
	 pass



#==== UI Interaction ====#

func on_deck_clicked(deck):
	_parent.on_mc_deck_clicked()

func on_new_deck_button_clicked():
	var total_decks = _grid.get_child_count()
	if total_decks >= _max_decks:
		return
	var deck_item = ObjectFactory.instance_deck_item()
	_grid.add_child(deck_item)
	var deck_name = str("New Deck ", total_decks+1)
	var deck_description = "This is a new awesome deck you just created."
	deck_item.initialize(deck_name, deck_description, null)
	deck_item.connect("on_deck_item_clicked", self, "on_deck_clicked")

func on_back_button_clicked():
	_parent.on_mc_back_button_clicked()


func _on_NewDeckButton_pressed():
	pass # Replace with function body.
