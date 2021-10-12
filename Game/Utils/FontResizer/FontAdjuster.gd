extends Node

#==== Class Comments ====#
# This class handles ajudsting font properties. These actions include
# resizing a font depending on the area that contains it.


#==== Bootstrap ====#

func initialize():
	#TODO catch signals
	pass



#==== Logic ====#

func get_font_size_adjustment(font, text, label_size, line_spacing, min_font_size):
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
		if adjustment_font.size < min_font_size:
			break
	return(adjustment)



