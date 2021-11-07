extends Node2D

#==== References ====#
onready var _parent = get_parent()

#==== Components ====#
#onready var _anim_timer = $AnimTimer

#==== Player ====#
onready var _opponent_slot = $OpponentExtinctionSlot
onready var _player_slot = $PlayerExtinctionSlot




#==== Bootstrap ====#

func _ready():
	return



#==== Player ====#

func send_player_growth_to_extinction(growth_card):
	_player_slot.set_card_on_slot_from_board(growth_card)



#==== Opponent ====#

func send_opponent_growth_to_extinction(growth_card):
	_opponent_slot.set_card_on_slot_from_board(growth_card)


func check_if_game_over():
	if int(_opponent_slot._label.text) >= 5:
		return true
	return false




