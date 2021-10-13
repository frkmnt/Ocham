extends Panel

#==== References ====#
var r_object_factory
var r_parent_menu
var r_card_editor_type

#==== Components ====#
var c_deck_editor_accordion = preload("res://UI/MainMenu/CollectionPanel/DeckEditorPanel/CardAccordion/Accordion.tscn")
var c_deck_editor_item = preload("res://UI/MainMenu/CollectionPanel/DeckEditorPanel/CardAccordion/Item.tscn")
#var c_deck_prefab = preload("res://Cards/Decks/Deck.tscn")

var c_accordion_container 
var c_title

#==== Variables ====#
var a_cards = [] #TODO check if useless
var s_file_path
var i_deck_index



#==== Bootstrap ====#

func initialize():
	r_object_factory = get_node("/root/GameOverseer/ObjectFactory")
	c_accordion_container = $ScrollContainer/List
	c_title = $Title
	create_accordion("Choose Cards") 
	create_accordion("Do Cards")
	create_accordion("Keep Cards")
	

func initialize_panel_with_deck(deck, file_path, deck_index):
	s_file_path = file_path
	i_deck_index = deck_index
	$Title.text = deck.s_name
	initialize_cards(deck)


func initialize_cards(deck_info):
	var deck = deck_info.d_deck
	
	add_cards_to_accordion(0, deck.get("0"))
	a_cards.append(deck_info.get_cards_of_type("0")) # choose cards
	
	add_cards_to_accordion(1, deck.get("1"))
	a_cards.append(deck_info.get_cards_of_type("1")) # do cards
	
	add_cards_to_accordion(2, deck.get("2"))
	a_cards.append(deck_info.get_cards_of_type("2")) # keep cards


func create_accordion(accordion_name):
	var item_instance = c_deck_editor_accordion.instance()
	item_instance.initialize(accordion_name)
	$ScrollContainer/List.add_child(item_instance)
	item_instance.rect_min_size = Vector2(1080, 620)

func add_cards_to_accordion(type_id, cards):
	var corrupted_cards = [] # cards that have been deleted from the file system
	if cards:
		var item_instance = $ScrollContainer/List.get_child(type_id)
		
		if cards.size() > 0:
			var card_data
			var card_data_path 
			
			for card_id in cards.keys():
				card_data_path = "user://Cards/" + String(card_id) 
				card_data = load_card_data(card_data_path, type_id)
				if card_data != null:
					item_instance.add_card(card_id, card_data.get_card_as_string(), cards[card_id])



func load_card_data(card_data_path, type_id):
	var card_prefab
	var file = File.new()
	if file.file_exists(card_data_path):
		file.open(card_data_path, File.READ)
		var content = parse_json(file.get_line())
		file.close()
		
		match type_id:
			0:
				card_prefab = r_object_factory.create_choose_card_prefab()
				card_prefab.s_option_a = content.get("card_info")[0]
				card_prefab.s_option_b = content.get("card_info")[1]
			1:
				card_prefab = r_object_factory.create_do_card_prefab()
				card_prefab.s_what_to_do = content.get("card_info")
			2:
				card_prefab = r_object_factory.create_keep_card_prefab()
				card_prefab.s_what_to_do = content.get("card_info")
		
		
	return card_prefab



#==== Logic ==== #

func add_card(card_type_id, card_data):
	var accordion = c_accordion_container.get_child(card_type_id)
	accordion.add_card(card_data.get_card_hash_id(), card_data.get_card_as_string(), 1)

func add_card_with_data(card_type_id, card_id, card_text):
	var accordion = c_accordion_container.get_child(card_type_id)
	accordion.add_card(card_id, card_text, 1)


func clear_info_from_panel():
	for accordion in c_accordion_container.get_children():
		accordion.clear_cards_from_accordion()


func create_deck_from_current_cards():
	pass
#	var deck_prefab = c_deck_prefab.instance()
#	deck_prefab.initialize_deck()
#	deck_prefab.s_name = c_title.text
#	deck_prefab.add_card_list(0, c_accordion_container.get_child(0).get_all_card_ids())
#	deck_prefab.add_card_list(1, c_accordion_container.get_child(1).get_all_card_ids())
#	deck_prefab.add_card_list(2, c_accordion_container.get_child(2).get_all_card_ids())
#	return deck_prefab


func close_all_accordions():
	for accordion in c_accordion_container.get_children():
		accordion.c_content_panel.shrink_panel()


#==== UI Interaction ====#

func on_open():
	visible = true
	grab_focus()


func on_close():
	visible = false
	r_parent_menu.on_open()


func on_delete_button_click():
	on_close()
	r_parent_menu.delete_deck(s_file_path, i_deck_index)


func on_add_card_button_click():
	r_card_editor_type.visible = true
	self.visible = false


func on_back_button_click():
	var deck = create_deck_from_current_cards()
	r_parent_menu.save_deck(deck)
	clear_info_from_panel()
	close_all_accordions()
	on_close()


