extends Area2D

#==== References ====#
onready var _card = get_parent()

#==== Components ====#
onready var _pos_tween = $PosTween
onready var _scale_tween = $ScaleTween
onready var _flip_tween = $FlipTween
onready var _glow_tween = $GlowTween
onready var _fade_tween = $FadeTween

#==== Settings ====#
var _locked = true # if true, the card cannot be dragged
var _snapback = true # if the card should snapback to its original pos after left release
var _flipped = false # if the cardback is visible
var _can_target = false # 
var _is_opponent_card = false

#==== Variables ====#
var _order = 0 # order in which the card should be rendered


var _original_pos = Vector2(0, 0) # position before being clicked
var _original_scale = Vector2(0, 0) # position before being clicked
var _mouse_offset_pos = Vector2(0, 0) # relative to the mouse position

var _flip_scale = Vector2(0, 0)



#==== Bootstrap ====#

func _ready():
	_original_scale = _card.scale
	resize_font()





#==== Mouse Events ====#

func on_mouse_entered():
	apply_glow()
	if not _locked and not _is_opponent_card:
		var new_pos = Vector2(_card.position.x, _card.position.y-_card.get_card_height()/2)
		interp_to_position(new_pos, 0.5)

func on_mouse_exited():
	cancel_glow()
	if not _locked and not _is_opponent_card:
		interp_to_original_position(0.5)



func on_left_click(event):
	_pos_tween.stop_all()
	_mouse_offset_pos = event.position - _card.global_position
	_card._container.on_card_click(_card)


func on_right_click():
	return


func on_mouse_motion(event):
	if not _locked:
		_pos_tween.stop_all()
		_card.global_position = event.position - _mouse_offset_pos




#==== Animation ====#

func set_flipped(is_flipped):
	if is_flipped:
		_card._frame._cardback.visible = true
	else:
		_card._frame._cardback.visible = false

func flip_to_back(callback):
	_flipped = true
	_flip_scale = _card.scale
	_flip_tween.interpolate_property(_card, "scale", _card.scale, Vector2(0.0, _card.scale.y), 
		0.25, Tween.EASE_OUT, Tween.EASE_IN, 0)
	_flip_tween.interpolate_callback(self, 0.25, callback)
	_flip_tween.start()

func finish_flip_to_back(): # 2 part anim
	self._card._frame._cardback.visible = true
	_flip_tween.interpolate_property(_card, "scale", _card.scale, _flip_scale, 
		0.25, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	_flip_tween.start()


func flip_to_front(callback):
	_flipped = false
	_flip_scale = _card.scale
	_flip_tween.interpolate_property(_card, "scale", _card.scale, Vector2(0.0, _card.scale.y), 
		0.5, Tween.EASE_OUT, Tween.EASE_IN, 0)
	_flip_tween.interpolate_callback(self, 0.5, callback)
	_flip_tween.start()

func finish_flip_to_front(): # 2 part anim
	self._card._frame._cardback.visible = false
	_flip_tween.interpolate_property(_card, "scale", _card.scale, _flip_scale, 
		0.25, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	_flip_tween.start()




func add_to_hand_anim(new_scale):
	scale_card(new_scale)
	set_flipped(true)
	flip_to_front("finish_flip_from_deck")

func opponent_add_to_hand_anim(new_scale):
	scale_card(new_scale)
	set_flipped(true)
	opponent_move_to_hand()

func finish_flip_from_deck():
	set_flipped(false)
	var hand_scale = _card._container._desired_scale
	_flip_tween.interpolate_property(_card, "scale", _card.scale, hand_scale, 
		0.25, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	_flip_tween.interpolate_callback(self, 0.5, "move_to_hand")
	_flip_tween.start()

func move_to_hand():
	var hand_scale = _card._container._desired_scale
	_flip_tween.interpolate_property(_card, "scale", _card.scale, hand_scale, 
		0.25, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	_flip_tween.interpolate_callback(self, 0.5, "finish_hand_animation")
	_flip_tween.start()
	_card._container.position_cards_correctly_interp()

func opponent_move_to_hand():
	var hand_scale = _card._container._desired_scale
	_flip_tween.interpolate_property(_card, "scale", _card.scale, hand_scale, 
		0.25, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	_flip_tween.interpolate_callback(self, 0.5, "finish_hand_animation")
	_flip_tween.start()
	_card._container.position_cards_correctly_interp()


func finish_hand_animation():
	_locked = false



#==== Glow ====#

func apply_glow():
	_card._frame.apply_glow()

func cancel_glow():
	_card._frame.cancel_glow()


#==== Z Order ====#

func set_original_z_index():
	_card.z_index = _order



#==== Position ====#

func interp_to_original_position(anim_dur):
	_pos_tween.interpolate_property(_card, "position", _card.position, _original_pos, 
	anim_dur, Tween.TRANS_BACK, Tween.EASE_OUT, 0)
	_pos_tween.start()

func interp_to_position(new_pos, anim_dur):
	_pos_tween.interpolate_property(_card, "position", _card.position, new_pos, 
	anim_dur, Tween.TRANS_BACK, Tween.EASE_OUT, 0)
	_pos_tween.start()

func interp_to_global_position(new_pos, anim_dur):
	_pos_tween.interpolate_property(_card, "global_position", _card.global_position, new_pos, 
	anim_dur, Tween.TRANS_BACK, Tween.EASE_OUT, 0)
	_pos_tween.start()


#==== Scale ====#

func scale_card(new_scale):
	_card.set_scale(new_scale)
	resize_font()

func scale_interp_to_original():
	_flip_tween.interpolate_property(_card, "scale", _card.scale, _original_scale, 
		0.5, Tween.EASE_OUT, Tween.EASE_IN, 0)
	_flip_tween.start()
	resize_font_target_scale(_original_scale)

func scale_interp(target_scale):
	_flip_tween.interpolate_property(_card, "scale", _card.scale, target_scale, 
		0.5, Tween.EASE_OUT, Tween.EASE_IN, 0)
	_flip_tween.start()
	resize_font_target_scale(target_scale)



#==== Fade ====#

func play_fade_out(callback):
	if not is_instance_valid(_card):
		return
	var new_modulate = _card.modulate
	new_modulate.a = 0.0
	_fade_tween.interpolate_property(_card, "modulate", _card.modulate, new_modulate, 
		0.75, Tween.EASE_OUT, Tween.EASE_IN, 0)
	_fade_tween.interpolate_callback(self, 0.5, callback)
	_fade_tween.start()


func remove_card():
	_card.queue_free()


#==== Card Slot ====#

func set_on_card_slot():
	if _card._container:
		_card._container.set_card_on_card_slot(_card)




#==== Font ====#

func resize_font():
	CardManager.resize_font(_card)

func resize_font_target_scale(target_scale):
	CardManager.resize_font_target_scale(_card, target_scale)



