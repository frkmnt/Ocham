extends Node2D

#==== References ====#
onready var _parent = get_parent()

#==== Meta Variables ====#
var _selected_card = null
var _targeting_card = null
var _topmost_card = null




#==== Input ====#

func _input(event):
	if event is InputEventMouseButton:
		handle_mouse_input(event)
	elif event is InputEventMouseMotion: # on motion while left clicked
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
		else:
			on_right_release()

func on_left_click(event):
	if not _parent._player_turn:
		return
	
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
		var interaction_handler = _selected_card._interaction_handler
		if interaction_handler._can_target and _selected_card._data.can_attack():
			_targeting_card = _selected_card
			print("locking")
		elif interaction_handler._locked:
			interaction_handler.on_left_click(event)
			print("selecting")





func on_left_release():
	if not _parent._player_turn:
		return
	if _selected_card != null:
		var all_shapes = get_world_2d().direct_space_state.intersect_point(get_global_mouse_position(), 32, [], 0x7FFFFFFF, false, true)
		var card_slot
		var interaction_handler = _selected_card._interaction_handler
		var data = _selected_card._data
		if interaction_handler._can_target and data.can_attack():
			var _in_game_manager = _selected_card._container._parent
			for shape in all_shapes:
				shape = shape["collider"]
				if shape.is_in_group("card_slot"):
					card_slot = shape
					if card_slot._card != null:
						if card_slot._is_attackable_growth_slot:
							_in_game_manager.attack_growth(_selected_card, card_slot._card)
							break
						if card_slot._is_attackable_active_slot:
							_in_game_manager.attack_active(_selected_card, card_slot._card)
							break
		elif not interaction_handler._locked: # place in card slot
			for shape in all_shapes:
				shape = shape["collider"]
				if shape.is_in_group("card_slot"):
					card_slot = shape
					if card_slot._is_playable_slot:
						var card_cost = _selected_card._data._cost
						if card_cost <= _parent._cur_mana:
							_parent._cur_mana -= card_cost
							card_slot.set_card_on_slot_from_hand(_selected_card)
							_selected_card._container._parent._mana_container.set_player_mana(_parent._cur_mana)
						else:
							interaction_handler.interp_to_original_position(0.5)
							_selected_card._container._parent._mana_container.player_not_enough_mana()
						break
			if card_slot == null:
				interaction_handler.interp_to_original_position(0.5)
				interaction_handler.set_original_z_index()
	_selected_card = null
	_targeting_card = null
	CursorManager.set_default_cursor()


func on_right_click():
	if _selected_card != null:
		return
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

func handle_mouse_motion(event):
	if  _selected_card:
		var interaction_handler = _selected_card._interaction_handler
		var data = _selected_card._data
		if not interaction_handler._locked:
			interaction_handler.on_mouse_motion(event)
		elif interaction_handler._can_target and data.can_attack():
			CursorManager.set_targeting_cursor()
	else:
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
		if topmost_card != null and not topmost_card._interaction_handler._is_opponent_card:
			if _topmost_card == null:
				_topmost_card = topmost_card
				_topmost_card._interaction_handler.on_mouse_entered()
				_topmost_card.z_index = _topmost_card._container.get_child_count()
			elif _topmost_card == topmost_card:
				return
			else:
				_topmost_card._interaction_handler.on_mouse_exited()
				_topmost_card.z_index = _topmost_card._interaction_handler._order
				_topmost_card = topmost_card
				_topmost_card._interaction_handler.on_mouse_entered()
				_topmost_card.z_index = _topmost_card._container.get_child_count()
		elif _topmost_card != null:
			_topmost_card._interaction_handler.on_mouse_exited()
			_topmost_card.z_index = _topmost_card._interaction_handler._order
			_topmost_card = null
