extends Node2D


#==== Geometry ====#
onready var _card_oval = get_viewport().size * Vector2(0.5, 1.25) # the card positioning is based on an oval
var _oval_angle_vec = Vector2()
onready var _h_rad = get_viewport().size.x * 0.45
onready var _v_rad = get_viewport().size.y * 0.4
var _angle = deg2rad(45)


#==== Bootstrap ====#

func _ready():
	position = _card_oval
	print(position)
	position_all_cards()


func _input(event):
	pass



#==== Position Cards ====#

func position_all_cards():
	var i = 0
	for card in get_children():
		var card_original_size = CardManager._card_size
		var card_size = card.get_card_size()
		
		_oval_angle_vec = Vector2(_h_rad * cos(_angle), - _v_rad * sin(_angle))
		print(_card_oval + _oval_angle_vec)
		card.position = _card_oval + _oval_angle_vec 
		card.position.y -= 500
#		card.scale *= card_size / card_original_size
#		card.rotation = (90 - rad2deg(_angle)) / 4
		_angle += 0.25
		card._common._order = i
		card.z_index = i
		i += 1
