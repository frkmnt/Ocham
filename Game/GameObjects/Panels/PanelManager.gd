extends Control

#==== Class Comments ====#
# Aliases: mm -> main menu


#==== Components ====#
var _mmm # main menu manager
var _igm # in game instance

#==== Bootstrap ====#


func _ready():
	_mmm = $MainMenuManager




#==== Game-Menu Interface ====#

func go_to_game(deck):
	# TODO add loading screen
	var in_game_instance = ObjectFactory.instance_in_game_manager()
	_igm = in_game_instance
	add_child(in_game_instance)
	_mmm.queue_free()
	in_game_instance.initialize(deck)

