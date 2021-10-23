extends Node

#==== Signals ====#
signal card_effect_resize_font

#==== References ====#
onready var _card



#==== Bootstrap ====#

func initialize(card):
	_card = card
	resize_font()



#==== Transform ====#

func scale_card(new_scale):
	_card.scale = new_scale
	resize_font()



#==== Font ====#

func resize_font():
	CardManager.resize_font(_card)
