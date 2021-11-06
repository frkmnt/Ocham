extends Node2D

#==== Class Comments ====#
# Handles all card related operations.


#==== Components ====#
onready var _card_previewer = $CardPreviewer

var _card_size = load("res://Assets/Graphics/Card/Border/border.png").get_size()
var _min_font_size = 35



#==== Fonts ====#

func resize_font(card):
	var description_label = card._frame._description_label
	var font = description_label.get("custom_fonts/font")
	var original_size = font.size
	var text = description_label.text
	var label_size = description_label.rect_min_size
	var line_spacing = description_label.get("custom_constants/line_spacing")
	var size_adjustment = get_font_size_adjustment(font, text, label_size, line_spacing)
	font.size = original_size + size_adjustment
	if font.size < _min_font_size:
		font.size = _min_font_size

func resize_font_target_scale(card, target_scale):
	var description_label = card._frame._description_label
	var font = description_label.get("custom_fonts/font")
	var original_size = font.size
	var text = description_label.text
	var label_size = description_label.rect_min_size * target_scale
	var line_spacing = description_label.get("custom_constants/line_spacing")
	var size_adjustment = get_font_size_adjustment(font, text, label_size, line_spacing)
	font.size = original_size + size_adjustment
	if font.size < _min_font_size:
		font.size = _min_font_size

func get_font_size_adjustment(font, text, label_size, line_spacing):
	var adjustment_font = font.duplicate(true)
	var line_height = font.get_height()
	var adjustment = 0
	var label_rect_y = adjustment_font.get_wordwrap_string_size(
			text, label_size.x).y \
			/ line_height \
			* (line_height + line_spacing) \
			- line_spacing
	while label_rect_y > label_size.y:
		adjustment -= 1
		adjustment_font.size = font.size + adjustment
		line_height = adjustment_font.get_height()
		label_rect_y = adjustment_font.get_wordwrap_string_size(
				text,label_size.x).y \
				/ line_height \
				* (line_height + line_spacing) \
				- line_spacing
		if adjustment_font.size < 5:
			break
	return(adjustment)


