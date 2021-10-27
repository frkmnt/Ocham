extends Node


#==== Deck Item ====#
const _deck_item = preload("res://GameObjects/Panels/MainMenu/CollectionPanel/MainCollectionPanel/DeckItem/DeckItem.tscn")
func instance_deck_item():
	return _deck_item.instance()

#==== Accordion Item ====#
const _accordion_item = preload("res://GameObjects/Panels/MainMenu/CollectionPanel/DeckEditorPanel/CardAccordion/Item.tscn")
func instance_accordion_item():
	return _accordion_item.instance()


#==== Card Grid ====#
const _card_grid = preload("res://GameObjects/Panels/Components/CardGrid/CardGrid.tscn")
func instance_card_grid():
	return _card_grid.instance()

