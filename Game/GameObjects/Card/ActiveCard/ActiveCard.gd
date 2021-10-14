extends Control

#==== Class Comments ====#
# Active cards are played in the top slots. They have a cost and
# an associated attack value. 
# //TODO test if the font "duplicate" has an effect 

#== Components ==#
onready var description_label = $DescriptionLabel

#== Variables ==#
var _cost = 0
var _power = 0
var _effect = ""



#==== Bootstrap ====#

func _ready():
	var font = description_label.get("custom_fonts/font")
	var original_size = font.size
	var text = description_label.text
#	description_label.text = "This is a really long description I made to see if it fits inside the card. It does."
	var label_size = description_label.rect_min_size
	var line_spacing = description_label.get("custom_constants/line_spacing")
	
	var size_adjustment = get_font_size_adjustment(font, text, label_size, line_spacing)
	font.size = original_size + size_adjustment



#==== Update Values ====#

func set_new_text (new_text):
	description_label



#==== Logic ====#

func get_font_size_adjustment(font, text, label_size, line_spacing):
	var adjustment_font = font.duplicate(true)
	var line_height = font.get_height()
	var adjustment = 0
	# line_spacing should be calculated into rect_size
	# This calculates the amount of vertical pixels the text would take
	# once it was word-wrapped.
	var label_rect_y = adjustment_font.get_wordwrap_string_size(
			text, label_size.x).y \
			/ line_height \
			* (line_height + line_spacing) \
			- line_spacing
	# If the y-size of the wordwrapped text would be bigger than the current
	# available y-size foir this label, we reduce the text, until we
	# it's small enough to stay within the boundaries
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
