extends Node

#==== References ====#
onready var _parent = get_parent()

#==== Components ====#
onready var _anim_timer = $AnimTimer

#==== Player ====#
onready var _player_growth_1 = $PlayerGrowth1
onready var _player_growth_2 = $PlayerGrowth2
onready var _player_growth_3 = $PlayerGrowth3
onready var _player_active_1 = $PlayerActive1
onready var _player_active_2 = $PlayerActive2
onready var _player_active_3 = $PlayerActive3

#==== Opponent ====#
onready var _opponent_growth_1 = $OpponentGrowth1
onready var _opponent_growth_2 = $OpponentGrowth2
onready var _opponent_growth_3 = $OpponentGrowth3
onready var _opponent_active_1 = $OpponentActive1
onready var _opponent_active_2 = $OpponentActive2
onready var _opponent_active_3 = $OpponentActive3

#==== Variables ====#
var _has_flipped_player_growth = false
var _has_flipped_opponent_growth = false

var _cur_slot_list



#==== Bootstrap ====#

func _ready():
	_anim_timer.connect("timeout", self, "on_flip_growth_timer_tick")



#==== Growth Interaction ====#

func flip_player_growth_cards():
	_has_flipped_player_growth = true
	_cur_slot_list = [_player_growth_1, _player_growth_2, _player_growth_3]
	_anim_timer.set_wait_time(0.3)
	_anim_timer.start()
	on_flip_growth_timer_tick()

func flip_opponent_growth_cards():
	_has_flipped_opponent_growth = true
	_cur_slot_list = [_opponent_growth_1, _opponent_growth_2, _opponent_growth_3]
	_anim_timer.start()
	on_flip_growth_timer_tick()

func on_flip_growth_timer_tick():
	if _cur_slot_list.size() > 0:
		_cur_slot_list[0]._card._interaction_handler.flip_to_front("finish_flip_to_front")
		_cur_slot_list.pop_front()
		_anim_timer.set_wait_time(0.3)
	else:
		_anim_timer.stop()
		_parent.start_timer(0.5, "turn_start_stage_2")



#==== Attack ====#

func can_attack_active():
	return true

func can_attack_growth():
	var can_attack = true
	if _opponent_active_1._card != null \
	or _opponent_active_2._card != null \
	or _opponent_active_3._card != null:
		can_attack = false
	return can_attack




#==== Get Containers By Index ====#

func get_player_active_slot(idx):
	var slot
	match idx:
		0:
			slot = _player_active_1
		1:
			slot = _player_active_2
		2:
			slot = _player_active_3
	return slot

func get_player_active_slots():
	return [_player_active_1, _player_active_2, _player_active_3]

func get_player_growth_slot(idx):
	var slot
	match idx:
		0:
			slot = _player_growth_1
		1:
			slot = _player_growth_2
		2:
			slot = _player_growth_3
	return slot

func get_player_growth_slots():
	return [_player_growth_1, _player_growth_2, _player_growth_3]


func get_opponent_active_slot(idx):
	var slot
	match idx:
		0:
			slot = _opponent_active_1
		1:
			slot = _opponent_active_2
		2:
			slot = _opponent_active_3
	return slot

func get_opponent_active_slots():
	return [_opponent_active_1, _opponent_active_2, _opponent_active_3]

func get_opponent_growth_slot(idx):
	var slot
	match idx:
		0:
			slot = _opponent_growth_1
		1:
			slot = _opponent_growth_2
		2:
			slot = _opponent_growth_3
	return slot

func get_opponent_growth_slots():
	return [_opponent_growth_1, _opponent_growth_2, _opponent_growth_3]







