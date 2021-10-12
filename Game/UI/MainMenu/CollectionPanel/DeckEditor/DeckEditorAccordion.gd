extends Control

#==== Components ====#
var c_content_panel


#==== Variables ====#

export var spacing = 0



#==== Bootstrap ====#

func initialize(name):
	$ShowContentButton.text = name
	c_content_panel = $ContentPanel
	c_content_panel.initialize(self)



#==== Tick ====#

func _draw():
	var last_end_pos = Vector2.ZERO
	for child in get_children():
		child.rect_position = last_end_pos
		last_end_pos.y = child.rect_position.y + child.rect_size.y 
		last_end_pos.y += spacing
	rect_min_size.y = last_end_pos.y #to work with ScrollContainer



#==== Logic ====#


func add_card(card_id, description, qty):
	c_content_panel.add_card(card_id, description, qty)


func clear_cards_from_accordion():
	c_content_panel.remove_all_cards()

func remove_card(index):
#	c_content_panel.get_child(0).get_child(index).queue_free()
	c_content_panel.remove_card(index)


func get_all_card_ids():
	var card_id_list = []
	for child in c_content_panel.get_child(0).get_children():
		card_id_list.append([child.i_card_id, int(child.c_quantity.text)])
	return card_id_list










