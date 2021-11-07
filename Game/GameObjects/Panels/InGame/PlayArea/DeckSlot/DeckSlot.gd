extends Area2D

#==== Components ====#
onready var _shape = $CollisionShape2D
onready var _total_cards_label = $TotalCardsLabel

#==== Components ====#
onready var _card_back = $CardBack

#==== References ====#
var _card = null

#==== Variables ====#
var _size 
var _margin = 0.03

#==== Logic ====#
var _card_list = []


#==== Bootstrap ====#

func _ready():
	_size = _shape.shape.extents * 2
	resize_card_back()

func resize_card_back():
	var new_scale = _size / _card_back.texture.get_size()
	new_scale -= new_scale * _margin
	_card_back.scale = new_scale

func calculate_card_scale():
	return _card_back.scale


#==== Card Management ====#

func draw_card():
	print("draw ", name)
	_total_cards_label.text = str(int(_total_cards_label.text) - 1)

func update_total_cards(new_qty):
	_total_cards_label.text = str(new_qty)
