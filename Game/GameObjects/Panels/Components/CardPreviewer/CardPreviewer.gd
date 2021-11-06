extends Node2D

#==== Components ====#
onready var _fade_tween = $FadeTween
onready var _card_container = $CardContainer
var _card = null

#==== Variables ====#
var _is_animating = false


#==== Bootstrap ====#

func init_with_card(card):
	_card = card
	_card_container.add_child(_card) 
	_card.set_scale(Vector2(1.0, 1.0))
	_card.global_position = position


#==== Fade Animations ====#

func play_fade_in():
	if _is_animating:
		_fade_tween.stop_all()
	_is_animating = true
	_card.modulate.a = 0.0
	var new_modulate = _card.modulate
	new_modulate.a = 1.0
	_fade_tween.interpolate_property(_card, "modulate", _card.modulate, new_modulate, 
		0.3, Tween.EASE_OUT, Tween.EASE_IN, 0)
	_fade_tween.start()


func play_fade_out():
	if not is_instance_valid(_card):
		return
	var new_modulate = _card.modulate
	new_modulate.a = 0.0
	_fade_tween.interpolate_property(_card, "modulate", _card.modulate, new_modulate, 
		0.3, Tween.EASE_OUT, Tween.EASE_IN, 0)
	_fade_tween.interpolate_callback(self, 0.5, "on_fade_out_finished")
	_fade_tween.start()

func on_fade_out_finished():
	_is_animating = false
	for child in _card_container.get_children():
		child.queue_free()
