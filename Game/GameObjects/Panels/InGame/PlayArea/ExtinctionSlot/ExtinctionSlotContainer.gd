extends Node2D

#==== References ====#
onready var _parent = get_parent()

#==== Components ====#
#onready var _anim_timer = $AnimTimer

#==== Player ====#
onready var _player_growth = $OpponentExtinctionSlot
onready var _opponent_active = $PlayerExtinctionSlot




#==== Bootstrap ====#

func _ready():
	return



#==== Player ====#

func send_player_growth_to_extinction(growth_card):
	_player_growth.set_card_on_slot_from_board(growth_card)



#==== Opponent ====#

func send_opponent_growth_to_extinction(growth_card):
	_player_growth.set_card_on_slot_from_board(growth_card)







