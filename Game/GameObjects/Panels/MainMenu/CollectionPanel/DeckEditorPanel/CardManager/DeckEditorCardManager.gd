extends Node2D

#==== Class Comments ====#
# Handles all card related operations.


#==== Variables ====#
var _topmost_card



#==== Input ====#

func _input(event):
	if event is InputEventMouseButton:
		handle_mouse_input(event)
	elif event is InputEventMouseMotion: # on motion while left clicked
		handle_mouse_motion()


#==Mouse Input==#

func handle_mouse_input(event):
	if event.button_index == BUTTON_LEFT: # on left click
		if event.is_pressed():
			on_left_click(event)
	elif event.button_index == BUTTON_RIGHT:
		if event.is_pressed():
			on_right_click()
		else:
			on_right_release()


func on_left_click(event):
	var all_shapes = get_world_2d().direct_space_state.intersect_point(get_global_mouse_position(), 32, [], 0x7FFFFFFF, false, true)
	var card
	for shape in all_shapes: # get all desired shapes
		shape = shape["collider"]
		if shape.is_in_group("card"):
			card = shape._card
			card._interaction_handler.on_left_click(event)


func on_right_click():
	var all_shapes = get_world_2d().direct_space_state.intersect_point(get_global_mouse_position(), 32, [], 0x7FFFFFFF, false, true)
	var card
	var topmost_card
	var highest_z_index = -1
	for shape in all_shapes: # get all desired shapes
		shape = shape["collider"]
		if shape.is_in_group("card"):
			card = shape._card
			if card.z_index > highest_z_index:
				topmost_card = card
				highest_z_index = card.z_index
	if topmost_card != null:
		var card_preview = topmost_card.duplicate(false)
		CardManager._card_previewer.init_with_card(card_preview)
		CardManager._card_previewer.play_fade_in()
		topmost_card._interaction_handler.on_right_click()

func on_right_release():
	if CardManager._card_previewer._card != null:
		CardManager._card_previewer.play_fade_out()




#==Mouse Motion==#

func handle_mouse_motion():
	var all_shapes = get_world_2d().direct_space_state.intersect_point(get_global_mouse_position(), 32, [], 0x7FFFFFFF, false, true)
	var card
	var topmost_card
	var highest_z_index = -1
	for shape in all_shapes: # get all desired shapes
		shape = shape["collider"]
		if shape.is_in_group("card"):
			card = shape._card
			if card.z_index > highest_z_index:
				topmost_card = card
				highest_z_index = card.z_index
	if topmost_card != null:
		if _topmost_card == null:
			_topmost_card = topmost_card
			_topmost_card._interaction_handler.on_mouse_entered()
		elif _topmost_card == topmost_card:
			return
		else:
			_topmost_card._interaction_handler.on_mouse_exited()
			_topmost_card = topmost_card
			_topmost_card._interaction_handler.on_mouse_entered()
	elif _topmost_card != null:
		_topmost_card._interaction_handler.on_mouse_exited()
		_topmost_card = null





