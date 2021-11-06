extends Node

#==== Components ====#
onready var _player_hand = $PlayerHand
onready var _opponent_hand = $OpponentHand

onready var _card_slot_container = $CardSlotContainer
onready var _deck_slot_container = $DeckSlotContainer
onready var _pile_slot_container = $PileSlotContainer
onready var _extinction_slot_container = $ExtinctionSlotContainer # TODO implement
onready var _mana_container = $ManaContainer

onready var _announcement_container = $AnnouncementContainer
onready var _anim_timer = $AnimTimer

#==== Settings ====#
var _hand_start_size = 5
var _hand_max_size = 10

#==== Deck ====#
var _deck

#==== Variables ====#
var _player_turn = false
var _total_rounds = 1
var _cur_mana = 1




#==== Bootstrap ====#

func _ready():
	randomize()
	_anim_timer.set_one_shot(true)
	get_first_player()
	_player_hand.initialize_card_size(_hand_max_size)
	_opponent_hand.initialize_card_size(_hand_max_size)
	_opponent_hand._anim_dur = 1.0

func initialize(deck):
	_deck = deck
	on_game_setup()


func get_first_player():
	_player_turn = true # TODO add random 50/50




#==== Draw Growth Cards ====#

func draw_initial_growth_cards():
	_deck_slot_container.draw_player_growth_cards(3)
	_deck_slot_container.draw_opponent_growth_cards(3)



func draw_growth_card(idx):
	if _player_turn:
		draw_player_growth_card(idx)
	else:
		draw_opponent_growth_card(idx)

func draw_player_growth_card(idx):
	var card_data = _deck.draw_growth_card()
	var card = create_new_card(card_data)
	var start_scale = _deck_slot_container.get_card_scale()
	var start_pos = _deck_slot_container._player_growth_deck.position
	var card_slot = _card_slot_container.get_player_growth_slot(idx)
	card_slot.set_card_on_slot_from_deck(card, start_pos, start_scale)
	_deck_slot_container._player_growth_deck.draw_card()

func draw_opponent_growth_card(idx):
	var card_data = _deck.draw_growth_card()
	var card = create_new_card(card_data)
	var start_scale = _deck_slot_container.get_card_scale()
	var start_pos = _deck_slot_container._opponent_growth_deck.position
	var card_slot = _card_slot_container.get_opponent_growth_slot(idx)
	card_slot.set_card_on_slot_from_deck(card, start_pos, start_scale)
	_deck_slot_container._opponent_growth_deck.draw_card()




#==== Draw Active Cards ====#

func draw_active_card():
	if _player_turn:
		draw_player_active_card()
	else:
		draw_opponent_active_card()

func draw_initial_active_cards():
	_deck_slot_container.draw_player_active_cards(5)
	_deck_slot_container.draw_opponent_active_cards(5)

func draw_player_active_card():
	var card_data = _deck.draw_active_card()
	var card = create_new_card(card_data)
	_player_hand.add_card_from_deck(card)
	card.global_position = _deck_slot_container._player_active_deck.global_position
	_deck_slot_container._opponent_active_deck.draw_card()
	var start_scale = _deck_slot_container.get_card_scale()
	card._interaction_handler.add_to_hand_anim(start_scale)
	_deck_slot_container._player_active_deck.draw_card()

func draw_opponent_active_card():
	var card_data = _deck.draw_active_card()
	var card = create_new_card(card_data)
	_opponent_hand.add_card_from_deck(card)
	card.global_position = _deck_slot_container._opponent_active_deck.global_position
	_deck_slot_container._opponent_active_deck.draw_card()
	var start_scale = _deck_slot_container.get_card_scale()
	var interaction_handler = card._interaction_handler
	interaction_handler.opponent_add_to_hand_anim(start_scale)
	interaction_handler._locked = true
	interaction_handler._is_opponent_card = true






func create_new_card(card_data):
	var card
	match card_data.type_name:
		"Active":
			card = CardLoader.instance_active_card_with_data(card_data)
		"Growth":
			card = CardLoader.instance_growth_card_with_data(card_data)
		"Fungi":
			card = CardLoader.instance_fungi_card_with_data(card_data)
		"Weather":
			card = CardLoader.instance_weather_card_with_data(card_data)
	return card




#==== First Turn ====#

func on_game_setup():
	_announcement_container.init_with_text("Prepare for Battle", "")
	draw_initial_growth_cards()
	draw_initial_active_cards()


#==== Turn Start ====#

func turn_start_stage_0():
	_announcement_container.init_with_text("Round " + str(_total_rounds), "turn_start_stage_1")

func turn_start_stage_1(): # on round label passed
	_anim_timer.stop()
	remove_latency_from_growth_cards()
	reveal_growth_cards()

func turn_start_stage_2(): # on growth_cards_revealed
	apply_growth_effects()
	get_mana_from_growth_cards()
	start_timer(0.5, "turn_start_stage_3")

func turn_start_stage_3():
	_anim_timer.stop()
	apply_active_effects()
	draw_active_card()
	# ask to draw growth card




func on_turn_end_stage_0():
	_total_rounds += 1
	_announcement_container.init_with_text("Round " + str(_total_rounds), "on_turn_end_stage_1")

func on_turn_end_stage_1():
	get_next_player()
	start_timer(1.0, "turn_start_stage_1")




#==== Growth Logic ====#

func reveal_growth_cards():
	if _player_turn and not _card_slot_container._has_flipped_player_growth:
		_card_slot_container.flip_player_growth_cards()
	elif not _card_slot_container._has_flipped_opponent_growth:
		_card_slot_container.flip_opponent_growth_cards()
	else:
		turn_start_stage_2()

func apply_growth_effects():
	var slot_list
	if _player_turn:
		slot_list = _card_slot_container.get_player_growth_slots()
	else:
		slot_list = _card_slot_container.get_opponent_growth_slots()
	var card
	for slot in slot_list:
		card = slot._card
		if card != null:
			return
			# TODO add effect

func remove_latency_from_growth_cards():
	var slot_list
	if _player_turn:
		slot_list = _card_slot_container.get_player_growth_slots()
	else:
		slot_list = _card_slot_container.get_opponent_growth_slots()
	var card
	for slot in slot_list:
		card = slot._card
		if card != null and not card._interaction_handler._flipped:
			card._data.add_latency_to_card(-1)

func get_mana_from_growth_cards():
	var slot_list
	if _player_turn:
		slot_list = _card_slot_container.get_player_growth_slots()
	else:
		slot_list = _card_slot_container.get_opponent_growth_slots()
	var total_mana = 0
	var card
	for slot in slot_list:
		card = slot._card
		if card != null:
			total_mana += int(card._data.get_mana_from_card())
			card._data.play_mana_anim()
	if _player_turn:
		_mana_container.set_player_mana(total_mana)
	else:
		_mana_container.set_opponent_mana(total_mana)
	_cur_mana = total_mana





#==== Active Logic ====#

func apply_active_effects():
	var slot_list
	if _player_turn:
		slot_list = _card_slot_container.get_player_active_slots()
	else:
		slot_list = _card_slot_container.get_opponent_active_slots()
	var card
	for slot in slot_list:
		card = slot._card
		if card != null and is_instance_valid(card):
			card._data.on_turn_start()
			# TODO add effect 


func set_player_active_card_on_slot(card, slot):
	pass


func set_opponent_active_card_on_slot(card, slot):
	pass




#==== Attacking ====#

func attack_active(attacker, target):
	var can_attack_active = _card_slot_container.can_attack_active()
	if can_attack_active:
		print("attacking active")
		attacker._data._has_attacked = true
		target._data.deal_damage(attacker._data._value)
	

func attack_growth(attacker, target):
	var can_attack_growth = _card_slot_container.can_attack_growth()
	if can_attack_growth:
		print("attacking growth")
		attacker._data._has_attacked = true
		target._data.deal_damage(attacker._data._value)


func on_active_card_defeated_stage_1(card):
	if _player_turn:
		_pile_slot_container.send_player_active_card(card)
	else:
		_pile_slot_container.send_opponent_active_card(card)
	start_timer(0.75, "on_active_card_defeated_stage_2", [card])


func on_active_card_defeated_stage_2(card):
	card._frame._animations.play("defeat")
	card._interaction_handler.play_fade_out(1.5, "remove_card")


func on_growth_card_defeated(card):
	_extinction_slot_container.send_player_growth_to_extinction(card)
	start_timer(0.75, "on_active_card_defeated_stage_2", [card])




#==== Opponent ====#

func play_opponent_card(_idx): # TODO upgrade to server
	var lowest_cost_card
	var lowest_cost_idx
	var lowest_cost = 99
	var idx = 0
	for card in _opponent_hand._card_list:
		if is_instance_valid(card) and card._data._cost < lowest_cost:
			lowest_cost_card = card
			lowest_cost_idx = idx
			lowest_cost = card._data._cost
		idx += 1
	_player_hand.remove_card(idx)
	_card_slot_container._opponent_active_2.set_card_on_slot_from_opponent_hand(lowest_cost_card)




#==== Utils ====#

func get_next_player():
	if _player_turn:
		_player_turn = false
	else:
		_player_turn = true


func start_timer(duration, callback, params=[]):
	var connections
	for cur_signal in _anim_timer.get_signal_list():
		connections = _anim_timer.get_signal_connection_list(cur_signal.name)
		for cur_con in connections:
			_anim_timer.disconnect(cur_con.signal, cur_con.target, cur_con.method)
			print(cur_con.signal);
			print(cur_con.target);
			print(cur_con.method);
	
	_anim_timer.connect("timeout", self, callback, params)
	_anim_timer.set_wait_time(duration)
	_anim_timer.start()


