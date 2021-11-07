extends Node



#==== Tick ====#

func _process(_delta):
	var in_game_manager 
	if Input.is_action_just_pressed("draw_card"):
		in_game_manager = get_tree().get_nodes_in_group("in_game_manager")[0] 
		in_game_manager.draw_active_card()
	if Input.is_action_just_pressed("play_card"):
		in_game_manager = get_tree().get_nodes_in_group("in_game_manager")[0] 
		in_game_manager.play_opponent_card(0)
	if Input.is_action_just_pressed("pass_turn"):
		in_game_manager = get_tree().get_nodes_in_group("in_game_manager")[0] 
		in_game_manager.on_turn_end_stage_0()
	if Input.is_action_just_pressed("victory"):
		in_game_manager = get_tree().get_nodes_in_group("in_game_manager")[0] 
		in_game_manager._announcement_container.play_victory_anim()
	if Input.is_action_just_pressed("set_extinction"):
		in_game_manager = get_tree().get_nodes_in_group("in_game_manager")[0] 
		in_game_manager._extinction_slot_container._player_slot._label.text = str(2)
