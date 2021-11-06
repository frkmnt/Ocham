extends Node

#==== References ====#
onready var _parent = get_parent()

#==== Components ====#
onready var _opponent_growth_deck = $OpponentGrowthDeckSlot
onready var _opponent_active_deck = $OpponentActiveDeckSlot
onready var _player_active_deck = $PlayerActiveDeckSlot
onready var _player_growth_deck = $PlayerGrowthDeckSlot

onready var _player_active_timer = $PlayerActiveAnimTimer
onready var _player_growth_timer = $PlayerGrowthAnimTimer
onready var _opponent_active_timer = $OpponentActiveAnimTimer
onready var _opponent_growth_timer = $OpponentGrowthAnimTimer

#==== Variables ====#
var _opponent_growth_drawn = false
var _opponent_active_drawn = false
var _player_active_drawn = false
var _player_growth_drawn = false


#==== Bootstrap ====#
func _ready():
	_player_active_deck.add_to_group("active_deck_slot")
	_player_growth_deck.add_to_group("growth_deck_slot")

#==== Card Scale ====#

func get_card_scale():
	return _player_active_deck.calculate_card_scale()


#==== Player Cards ====#

func draw_player_growth_cards(total_cards):
	_player_growth_timer.connect("timeout", self, "on_player_growth_timer_tick", [total_cards])
	_player_growth_timer.set_wait_time(3)
	_player_growth_timer.start()

func on_player_growth_timer_tick(total_cards):
	if total_cards > 0:
		_parent.draw_player_growth_card(3-total_cards)
		_player_growth_deck.draw_card()
		total_cards -= 1
		_player_growth_timer.disconnect("timeout", self, "on_player_growth_timer_tick") 
		_player_growth_timer.connect("timeout", self, "on_player_growth_timer_tick", [total_cards])
		_player_growth_timer.set_wait_time(0.5)
		_player_growth_timer.start()
	else:
		_player_growth_timer.stop()
		_player_growth_drawn = true
		check_if_initial_draw_is_complete()


func draw_player_active_cards(total_cards):
	_player_active_timer.connect("timeout", self, "on_player_active_timer_tick", [total_cards])
	_player_active_timer.set_wait_time(0.1)
	_player_active_timer.start()

func on_player_active_timer_tick(total_cards):
	if total_cards > 0:
		_parent.draw_player_active_card()
		_player_active_deck.draw_card()
		total_cards -= 1
		_player_active_timer.disconnect("timeout", self, "on_player_active_timer_tick") 
		_player_active_timer.connect("timeout", self, "on_player_active_timer_tick", [total_cards])
		_player_active_timer.set_wait_time(1.5)
		_player_active_timer.start()
	else:
		_player_active_timer.stop()
		_player_active_drawn = true
		check_if_initial_draw_is_complete()



#==== Opponents Cards ====#

func draw_opponent_growth_cards(total_cards):
	_opponent_growth_timer.connect("timeout", self, "on_opponent_growth_timer_tick", [total_cards])
	_opponent_growth_timer.set_wait_time(3)
	_opponent_growth_timer.start()

func on_opponent_growth_timer_tick(total_cards):
	if total_cards > 0:
		_parent.draw_opponent_growth_card(3-total_cards)
		_opponent_growth_deck.draw_card()
		total_cards -= 1
		_opponent_growth_timer.disconnect("timeout", self, "on_opponent_growth_timer_tick") 
		_opponent_growth_timer.connect("timeout", self, "on_opponent_growth_timer_tick", [total_cards])
		_opponent_growth_timer.set_wait_time(0.5)
		_opponent_growth_timer.start()
	else:
		_opponent_growth_timer.stop()
		_opponent_growth_drawn = true
		check_if_initial_draw_is_complete()


func draw_opponent_active_cards(total_cards):
	_opponent_active_timer.connect("timeout", self, "on_opponent_active_timer_tick", [total_cards])
	_opponent_active_timer.set_wait_time(0.1)
	_opponent_active_timer.start()

func on_opponent_active_timer_tick(total_cards):
	if total_cards > 0:
		_parent.draw_opponent_active_card()
		_opponent_active_deck.draw_card()
		total_cards -= 1
		_opponent_active_timer.disconnect("timeout", self, "on_opponent_active_timer_tick") 
		_opponent_active_timer.connect("timeout", self, "on_opponent_active_timer_tick", [total_cards])
		_opponent_active_timer.set_wait_time(1.5)
		_opponent_active_timer.start()
	else:
		_opponent_active_timer.stop()
		_opponent_active_drawn = true
		check_if_initial_draw_is_complete()


func check_if_initial_draw_is_complete():
	if _opponent_growth_drawn and _opponent_active_drawn \
		and _player_active_drawn and _player_growth_drawn:
			_parent.turn_start_stage_0()

