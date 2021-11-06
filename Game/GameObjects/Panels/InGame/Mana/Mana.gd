extends Node


#==== References ====#
onready var _label = $CenterContainer/Label
onready var _tween = $AnimTween

#==== References ====#
export var _font_size_increase = 100



#==== Bootstrap ====#

func _ready():
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://Assets/Fonts/Resources/Magicmedieval-pRV1.ttf")
	dynamic_font.size = 200
	_label.set("custom_fonts/font", dynamic_font)



#==== Set Values ====#

func set_mana(new_val):
	_label.text = str(new_val)


#==== Animation ====#

func play_add_mana_anim():
	var label_font = _label.get("custom_fonts/font")
	var original_size = label_font.size
	_tween.interpolate_property(label_font, "size", original_size, original_size + _font_size_increase, 
		0.25, Tween.EASE_OUT, Tween.EASE_IN, 0)
	var original_modulate = _label.get("custom_colors/font_color")
	var new_modulate = Color( 0, 1, 1, 1 )
	_tween.interpolate_property(_label, "custom_colors/font_color", original_modulate, new_modulate, 
		0.25, Tween.EASE_OUT, Tween.EASE_IN, 0)
	_tween.interpolate_callback(self, 0.5, "play_reset_mana_anim")
	_tween.start()

func play_use_mana_anim():
	var label_font = _label.get("custom_fonts/font")
	var original_size = label_font.size
	_tween.interpolate_property(label_font, "size", original_size, original_size + _font_size_increase, 
		0.1, Tween.EASE_OUT, Tween.EASE_IN, 0)
	var original_modulate = _label.get("custom_colors/font_color")
	var new_modulate = Color( 0, 1, 1, 1 )
	_tween.interpolate_property(_label, "custom_colors/font_color", original_modulate, new_modulate, 
		0.1, Tween.EASE_OUT, Tween.EASE_IN, 0)
	_tween.interpolate_callback(self, 0.25, "play_reset_mana_anim")
	_tween.start()

func play_not_enough_mana_anim():
	var label_font = _label.get("custom_fonts/font")
	var original_size = label_font.size
	_tween.interpolate_property(label_font, "size", original_size, original_size + _font_size_increase, 
		0.1, Tween.EASE_OUT, Tween.EASE_IN, 0)
	var original_modulate = _label.get("custom_colors/font_color")
	var new_modulate = Color( 1, 0, 0, 1 )
	_tween.interpolate_property(_label, "custom_colors/font_color", original_modulate, new_modulate, 
		0.1, Tween.EASE_OUT, Tween.EASE_IN, 0)
	_tween.interpolate_callback(self, 0.25, "play_reset_mana_anim")
	_tween.start()


func play_reset_mana_anim(): # called after the other anims are finished
	var label_font = _label.get("custom_fonts/font")
	var cur_size = label_font.size
	_tween.interpolate_property(label_font, "size", cur_size, cur_size - _font_size_increase, 
		0.25, Tween.EASE_OUT, Tween.EASE_IN, 0)
	var original_modulate = _label.get("custom_colors/font_color")
	var new_modulate = Color( 1, 1, 1, 1 )
	_tween.interpolate_property(_label, "custom_colors/font_color", original_modulate, new_modulate, 
		0.25, Tween.EASE_OUT, Tween.EASE_IN, 0)
	_tween.start()
