extends Node

#==== Components ====#
onready var _opp_growth_pile = $OpponentGrowthPile
onready var _opp_active_pile = $OpponentActivePile
onready var _player_active_pile = $PlayerActivePile
onready var _player_growth_pile = $PlayerGrowthPile



#==== Bootstrap ====#
func _ready():
	return
#	_player_active_pile.add_to_group("pile")
#	_player_growth_pile.add_to_group("pile")
