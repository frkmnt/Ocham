extends Control

#==== References ====#
onready var _parent = get_parent()

#==== Components ====#
onready var _center_container = $CenterContainer
onready var _label = $CenterContainer/AnnouncementLabel
onready var _animated_sprite = $AnimatedSprite
onready var _anim_timer = $AnimTimer
onready var _fade_tween = $FadeTween
onready var _pos_tween = $PosTween


#==== Settings ====#
export var _offset_from_center_y = 300

#==== Variables ====#
var _is_animating = false
var _callback


#==== Bootstrap ====#

func _ready():
	_anim_timer.connect("timeout", self, "play_fade_out")
	_animated_sprite.modulate.a = 0.0

func init_with_text(new_text, callback):
	_callback = callback
	_label.text = new_text
	play_fade_in()


#==== Animation ====#

func play_fade_in():
	if _is_animating:
		_pos_tween.stop_all()
		_fade_tween.stop_all()
	_is_animating = true
	
	var center_pos_y = calc_center_pos_y()
	var start_pos = _center_container.rect_position
	start_pos.y = center_pos_y + _offset_from_center_y
	var new_pos = _center_container.rect_position
	new_pos.y = center_pos_y
	_pos_tween.interpolate_property(_center_container, "rect_position", start_pos, new_pos, 
		1.5, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR, 0)
	var new_modulate = _center_container.modulate
	new_modulate.a = 1.0
	_fade_tween.interpolate_property(_center_container, "modulate", _center_container.modulate, new_modulate, 
		1.5, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR, 0)
	_anim_timer.set_wait_time(3)
	_anim_timer.start()
	_pos_tween.start()
	_fade_tween.start()

func play_fade_out():
	_is_animating = true
	var start_pos = _center_container.rect_position
	var new_pos = _center_container.rect_position
	new_pos.y = _center_container.rect_position.y - _offset_from_center_y
	_pos_tween.interpolate_property(_center_container, "rect_position", start_pos, new_pos, 
		1.0, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR, 0)
	var new_modulate = _center_container.modulate
	new_modulate.a = 0.0
	_fade_tween.interpolate_property(_center_container, "modulate", modulate, new_modulate, 
		1.0, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR, 0)
	_fade_tween.interpolate_callback(self, 0.5, "on_fade_out_finished")
	_anim_timer.stop()
	_pos_tween.start()
	_fade_tween.start()


func on_fade_out_finished():
	_is_animating = false
	if _parent.has_method(_callback):
		_parent.call(_callback)


func play_victory_anim():
	_animated_sprite.visible = true
	_animated_sprite.play("victory")
	_animated_sprite.modulate.a = 0.0
	var victory_modulate = _animated_sprite.modulate
	victory_modulate.a = 1.0
	_fade_tween.interpolate_property(_animated_sprite, "modulate", _animated_sprite.modulate, victory_modulate, 
		0.3, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR, 0)
	
	var new_modulate = _animated_sprite.modulate
	new_modulate.a = 1.0
	_fade_tween.interpolate_property(_animated_sprite, "modulate", modulate, new_modulate, 
		0.2, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR, 0)
	_fade_tween.start()




#==== Utils ====#

func calc_center_pos_y():
	return (_parent.rect_size.y - _center_container.rect_size.y) / 2
