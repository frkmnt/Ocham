extends Area2D

#==== Signals ====#
signal card_effect_resize_font

#==== References ====#
onready var _card = get_parent()

#==== Components ====#
onready var _pos_tween = $PosTween
onready var _flip_tween = $FlipTween
onready var _glow_tween = $GlowTween

#==== Settings ====#
var _locked = true # if true, the card cannot be dragged
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



#==== State ====#

func is_clickable():
	var is_clickable = true
	if _pos_tween.is_active():
		is_clickable = false
	return is_clickable





#==== Mouse Events ====#

func on_mouse_entered():
	_mouse_entered = true
	apply_glow()

func on_mouse_exited():
	_mouse_entered = false
	cancel_glow()


func on_left_click(event):
	_left_mouse_down = true
	_original_pos = _card.position
	_relative_pos = event.position - _card.position
	_card._container.on_card_click(_card)
#	flip_to_back()

func on_left_release():
	_left_mouse_down = false
	if _snapback:
		_is_snapping = true
		_pos_tween.interpolate_property(_card, "position", _card.position, _original_pos, 
		0.5, Tween.TRANS_BACK, Tween.EASE_OUT, 0)
		_pos_tween.start()

func on_right_click():
	apply_glow()


func on_mouse_motion(event):
	if not _locked:
		_card.position = event.position - _relative_pos




#==== Animation ====#

func flip_to_back():
	_flip_tween.interpolate_property(_card, "scale", _card.scale, Vector2(0.0, _card.scale.y), 
		0.5, Tween.EASE_OUT, Tween.EASE_IN, 0)
	_flip_tween.start()

func flip_to_front():
	pass



#==== Glow ====#

func apply_glow():
	_card._card_frame.apply_glow()

func cancel_glow():
	_card._card_frame.cancel_glow()



#==== Transform ====#

func scale_card(new_scale):
	_card.scale = new_scale
	resize_font()



#==== Font ====#

func resize_font():
	CardManager.resize_font(_card)



