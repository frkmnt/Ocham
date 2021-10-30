extends Area2D

#==== Components ====#
onready var _shape = $CollisionShape2D
onready var _sprite = $Sprite

#==== References ====#
var _card = null

#==== Variables ====#
var _size 
var _margin = 0.03

#==== Bootstrap ====#

func _ready():
	_size = _sprite.texture.get_size()


#==== Card Management ====#

func set_card_on_slot(card):
	_card = card
	var interaction_handler = _card._interaction_handler
	
	var new_scale = _size / _card.get_card_size()
	print(new_scale)
	print(_size)
	print(_card.get_card_size())
	new_scale -= new_scale * _margin
	new_scale *= _card.scale
	interaction_handler.scale_interp(new_scale)
	
	interaction_handler.interp_to_global_position(global_position)
	interaction_handler._locked = true

