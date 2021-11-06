extends Node2D

#==== Settings ====#
export var _font_size_increase = 20

#==== References ====#
onready var _card = get_parent()

#==== Components ====#
onready var _frame 
onready var _name_label 
onready var _description_label 
onready var _cost_label
onready var _value_label
onready var _card_glow
onready var _cardback
onready var _animations
onready var _tween

#==== Variables ====#
var card_name = "Card"
var description = ""
var rarity = 0
var rarity_name = ""
var cost = 1
var value = 1
var effect = 0
var effect_description = ""
var image_id = 0



#==== Bootstrap ====#

func _ready():
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://Assets/Fonts/Resources/Magicmedieval-pRV1.ttf")
	dynamic_font.size = 60
	_cost_label.set("custom_fonts/font", dynamic_font)
	_value_label.set("custom_fonts/font", dynamic_font)

func initialize(data_dict):
	initialize_values(data_dict)
	initialize_components()


func initialize_values(data_dict):
	card_name = data_dict.card_name
	description = data_dict.description
	rarity = data_dict.rarity
	rarity_name = data_dict.rarity_name
	cost = data_dict.cost
	value = data_dict.value
	effect = data_dict.effect
	effect_description = data_dict.effect_description
	image_id = data_dict.image_id

func initialize_components():
	_animations = $CardAnimations
	_frame = $Frame
	_name_label = $Frame/NameLabel
	_description_label = $Frame/DescriptionLabel
	_cost_label = $Frame/Cost/CenterContainer/CostLabel
	_value_label = $Frame/Centerpiece/Frame/ValueLabel
	_card_glow = $CardGlow
	_cardback = $Cardback
	_tween = $Tween
	_name_label.text = card_name
	_description_label.text = effect_description
	_value_label.text = str(value)
	_cost_label.text = str(cost)



#==== Transform ====#

func get_width():
	return _frame.texture.get_width()

func get_height():
	return _frame.texture.get_height()



#==== Glow ====#

func apply_glow():
	_card_glow.apply_glow()

func cancel_glow():
	_card_glow.cancel_glow()



#==== Accessors ====#

func gain_cost(new_cost):
	_cost_label.text = str(new_cost)
	play_gain_value_anim(_cost_label)

func lose_cost(new_cost):
	_cost_label.text = str(new_cost)
	play_gain_value_anim(_cost_label)

func gain_value(new_cost):
	_value_label.text = str(new_cost)
	play_gain_value_anim(_value_label)

func lose_value(new_cost):
	_value_label.text = str(new_cost)
	play_gain_value_anim(_value_label)



#==== Animation ====#

func play_gain_value_anim(target):
	var label_font = target.get("custom_fonts/font")
	var original_size = label_font.size
	_tween.interpolate_property(label_font, "size", original_size, original_size + _font_size_increase, 
		0.25, Tween.EASE_OUT, Tween.EASE_IN, 0)
	var original_modulate = target.get("custom_colors/font_color")
	var new_modulate = Color( 1, 0, 0, 1 )
	_tween.interpolate_property(target, "custom_colors/font_color", original_modulate, new_modulate, 
		0.2, Tween.EASE_OUT, Tween.EASE_IN, 0)
	_tween.interpolate_callback(self, 0.25, "play_reset_value_anim", target)
	_tween.start()

func play_lose_value_anim(target):
	var label_font = target.get("custom_fonts/font")
	var original_size = label_font.size
	_tween.interpolate_property(label_font, "size", original_size, original_size + _font_size_increase, 
		0.5, Tween.EASE_OUT, Tween.EASE_IN, 0)
	var original_modulate = target.get("custom_colors/font_color")
	var new_modulate = Color( 1, 0, 0, 1 )
	_tween.interpolate_property(target, "custom_colors/font_color", original_modulate, new_modulate, 
		0.5, Tween.EASE_OUT, Tween.EASE_IN, 0)
	_tween.interpolate_callback(self, 0.5, "play_reset_value_anim", target)
	_tween.start()


func play_reset_value_anim(target): # called after the other anims are finished
	var label_font = target.get("custom_fonts/font")
	var cur_size = label_font.size
	_tween.interpolate_property(label_font, "size", cur_size, cur_size - _font_size_increase, 
		0.25, Tween.EASE_OUT, Tween.EASE_IN, 0)
	var original_modulate = target.get("custom_colors/font_color")
	var new_modulate = Color( 1, 1, 1, 1 )
	_tween.interpolate_property(target, "custom_colors/font_color", original_modulate, new_modulate, 
		0.25, Tween.EASE_OUT, Tween.EASE_IN, 0)
	_tween.start()

