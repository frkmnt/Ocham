extends Node2D

#==== Class Comments ====#
# Handles all card related operations.

#==== Signals ====#
signal card_effect_resize_font

#==== Input Variables ====#
var _selected_card = null

var _card_size = load("res://Assets/Graphics/Card/Border/border.png").get_size()

#==== Bootstrap ====#

func _init():
	connect("card_effect_resize_font", self, "resize_font")






#==== Input ====#

func _input(event):
	if event is InputEventMouseButton:
		handle_mouse_input(event)
	elif event is InputEventMouseMotion and _selected_card: # on motion while left clicked
		handle_mouse_motion(event)


#==Mouse Input==#

func handle_mouse_input(event):
	if event.button_index == BUTTON_LEFT: # on left click
		if event.is_pressed():
			on_left_click(event)
		else:
			on_left_release()
	
	elif event.button_index == BUTTON_RIGHT:
		if event.is_pressed():
			on_right_click()

func on_left_click(event):
	var all_shapes = get_world_2d().direct_space_state.intersect_point(get_global_mouse_position(), 32, [], 0x7FFFFFFF, false, true)
	var card
	var highest_z_index = -1
	for shape in all_shapes: # get all desired shapes
		shape = shape["collider"]
		if shape.is_in_group("card"):
			card = shape._card
			if card.z_index > highest_z_index:
				_selected_card = card
				highest_z_index = card.z_index
	if _selected_card != null:
		_selected_card._common.on_left_click(event)
		_selected_card.z_index = _selected_card._container.get_child_count()

func on_left_release():
	if _selected_card != null:
		_selected_card._common.on_left_release()
		_selected_card.z_index = _selected_card._common._order
	_selected_card = null


func on_right_click():
	if _selected_card != null:
		return
	print("right_click")
	var all_shapes = get_world_2d().direct_space_state.intersect_point(get_global_mouse_position(), 32, [], 0x7FFFFFFF, false, true)
	var card
	var topmost_card
	var highest_z_index = -1
	for shape in all_shapes: # get all desired shapes
		shape = shape["collider"]
		if shape.is_in_group("card"):
			card = shape._card()
			if card.z_index > highest_z_index:
				topmost_card = card
				highest_z_index = card.z_index
	if topmost_card != null:
		print(topmost_card.name)
		topmost_card.on_right_click()

func on_right_release():
	pass




#==Mouse Motion==#

func handle_mouse_motion(event):
	_selected_card._common.on_mouse_motion(event)







#==== Transform ====#

func scale_card():
	pass



#==== Fonts ====#

func resize_font(card):
	var description_label = card._description_label
	var font = description_label.get("custom_fonts/font")
	var original_size = font.size
	var text = description_label.text
	var label_size = description_label.rect_min_size
	var line_spacing = description_label.get("custom_constants/line_spacing")
	var size_adjustment = get_font_size_adjustment(font, text, label_size, line_spacing)
	font.size = original_size + size_adjustment

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



#==== Highlight ====#

func highlight_card(card):
	pass
