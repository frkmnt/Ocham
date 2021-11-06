extends Node

#==== Components ====#
onready var _opp_active_pile = $OpponentActivePile
onready var _opp_growth_pile = $OpponentGrowthPile
onready var _player_active_pile = $PlayerActivePile
onready var _player_growth_pile = $PlayerGrowthPile



#==== Bootstrap ====#
func _ready():
	return



#==== Opponent ====#

func send_opponent_active_card(card):
	_opp_active_pile.set_card_on_slot_from_board(card)

func send_opponent_growth_card(card):
	_opp_growth_pile.set_card_on_slot_from_board(card)



#==== Player =====#

func send_player_active_card(card):
	_player_active_pile.set_card_on_slot_from_board(card)

func send_player_growth_card(card):
	_player_growth_pile.set_card_on_slot_from_board(card)


