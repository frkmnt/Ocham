extends Area2D

#==== Signals ====#
signal card_effect_resize_font

#==== References ====#
onready var _card = get_parent()

#==== Components ====#
onready var _pos_tween = $PosTween
onready var _scale_tween = $ScaleTween
onready var _flip_tween = $FlipTween
onready var _glow_tween = $GlowTween

#==== Settings ====#
var _locked = true # if true, the card cannot be dragged
var _snapback = true # if the card should snapback to its original pos after left release
var _in_game = false # if the card is in an in-game scenario

#==== Variables ====#
var _order = 0 # order in which the card should be rendered

var _mouse_entered = false
var _left_mouse_down = false
var _right_mouse_down = false
var _has_moved = false
var _is_snapping = false

var _original_pos = Vector2(0, 0) # position before being clicked
var _original_scale = Vector2(0, 0) # position before being clicked
var _relative_pos = Vector2(0, 0) # relative to the mouse position

var _flip_scale = Vector2(0, 0)



#==== Bootstrap ====#

func _initialize():
	resize_font()
	_original_pos = _card.position
	
	_original_scale = _card.scale


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

func on_left_release():
	_left_mouse_down = false
	if _snapback:
		_is_snapping = true
		_pos_tween.interpolate_property(_card, "position", _card.position, _original_pos, 
		0.5, Tween.TRANS_BACK, Tween.EASE_OUT, 0)
		_pos_tween.start()

func on_right_click():
	flip_to_back()
#	scale_interp(Vector2(0.3, 0.3))


func on_mouse_motion(event):
	if not _locked:
		_card.position = event.position - _relative_pos




#==== Animation ====#

func play_flip_anim():
	pass

func flip_to_back():
	_flip_scale = _card.scale
	_flip_tween.interpolate_property(_card, "scale", _card.scale, Vector2(0.0, _card.scale.y), 
		0.5, Tween.EASE_OUT, Tween.EASE_IN, 0)
	_flip_tween.interpolate_callback(self, 0.5, "finish_flip_to_back")
	_flip_tween.start()


func finish_flip_to_back(): # 2 part anim
	self._card._card_frame._cardback.visible = true
	_flip_tween.interpolate_property(_card, "scale", _card.scale, _flip_scale, 
		0.25, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	_flip_tween.start()




func flip_to_front():
	pass



#==== Glow ====#

func apply_glow():
	_card._card_frame.apply_glow()

func cancel_glow():
	_card._card_frame.cancel_glow()


#==== Z Order ====#

func set_original_z_index():
	_card.z_index = _order



#==== Position ====#

func interp_to_original_position():
	_is_snapping = true
	_pos_tween.interpolate_property(_card, "position", _card.position, _original_pos, 
	0.5, Tween.TRANS_BACK, Tween.EASE_OUT, 0)
	_pos_tween.start()

func interp_to_position(new_pos):
	_is_snapping = true
	_pos_tween.interpolate_property(_card, "position", _card.position, new_pos, 
	0.5, Tween.TRANS_BACK, Tween.EASE_OUT, 0)
	_pos_tween.start()

func interp_to_global_position(new_pos):
	_is_snapping = true
	_pos_tween.interpolate_property(_card, "global_position", _card.global_position, new_pos, 
	0.5, Tween.TRANS_BACK, Tween.EASE_OUT, 0)
	_pos_tween.start()


#==== Scale ====#

func scale_card(new_scale):
	_card.scale = new_scale
	resize_font()

func scale_interp_to_original():
	_flip_tween.interpolate_property(_card, "scale", _card.scale, _original_scale, 
		0.5, Tween.EASE_OUT, Tween.EASE_IN, 0)
#	_flip_tween.interpolate_callback(self, 0.5, "finish_flip_to_back") TODO add signal
	_flip_tween.start()

func scale_interp(target_scale):
	_flip_tween.interpolate_property(_card, "scale", _card.scale, target_scale, 
		0.5, Tween.EASE_OUT, Tween.EASE_IN, 0)
#	_flip_tween.interpolate_callback(self, 0.5, "finish_flip_to_back") TODO add signal
	_flip_tween.start()


#==== Font ====#

func resize_font():
	CardManager.resize_font(_card)



