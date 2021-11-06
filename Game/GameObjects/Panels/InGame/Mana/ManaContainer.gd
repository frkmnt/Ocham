extends Node

#==== Components ====#

onready var _opponent_mana_label = $OpponentMana
onready var _player_mana_label = $PlayerMana



#==== Opponent ====#

func set_opponent_mana(new_value):
	_opponent_mana_label.set_mana(new_value)
	_opponent_mana_label.play_add_mana_anim()


#==== Player ====#

func set_player_mana(new_value):
	_player_mana_label.set_mana(new_value)
	_player_mana_label.play_add_mana_anim()

func player_not_enough_mana():
	_player_mana_label.play_not_enough_mana_anim()
