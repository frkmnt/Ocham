extends Area2D

#==== Signals ====#
signal card_effect_resize_font

#==== References ====#
onready var _card = get_parent()

#==== Components ====#
onready var _tween = $Tween

#==== Settings ====#
var _snapback = true # if the card should snapback to its original pos after left release

#==== Variables ====#
var _order = 0 # order in which the card should be rendered

var _mouse_entered = false
var _left_mouse_down = false
var _right_mouse_down = false
var _has_moved = false
var _is_snapping = false

var _original_pos = Vector2(0, 0) # position before being clicked
var _relative_pos = Vector2(0, 0) # relative to the mouse position




#==== Bootstrap ====#

func _initialize():
	resize_font()
	_original_pos = _card.position


#==== Process ====#

func _process(delta):
	if _is_snapping:
		pass




#==== Mouse Events ====#

func on_mouse_entered():
	_mouse_entered = true

func on_mouse_exited():
	_mouse_entered = false



func on_left_click(event):
	_left_mouse_down = true
	_original_pos = _card.position
	_relative_pos = event.position - _card.position

func on_left_release():
	_left_mouse_down = false
	if _snapback:
		_is_snapping = true
		_tween.interpolate_property(_card, "position", _card.position, _original_pos, 
		0.5, Tween.TRANS_BACK, Tween.EASE_OUT, 0)
		_tween.start()
#		_card.position = _original_pos


func on_right_click():
	pass



func on_mouse_motion(event):
	_card.position = event.position - _relative_pos


#==== Transform ====#

func scale_card(new_scale):
	_card.scale = new_scale
	resize_font()



#==== Font ====#

func resize_font():
	CardManager.resize_font(_card)



