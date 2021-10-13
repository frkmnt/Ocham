extends Panel


#==== Components ====#
const c_vbox_item_prefab = preload("res://UI/MainMenu/CollectionPanel/DeckEditorPanel/CardAccordion/Item.tscn")

#==== References ====#
var r_vbox_container
var r_parent_menu

#==== Constants ====#
const i_card_panel_height = 50 # //TODO add to env 
const i_card_gap_height = 0

#==== Variables ====#
var is_expanded = false
var last_rect_size = Vector2.ZERO
var i_card_count = 0
var i_scaling_speed = 0.002




#==== Bootstrap ====#

func initialize(parent_menu):
	r_parent_menu = parent_menu
	r_vbox_container = $VBoxContainer
	shrink_panel()




#==== Logic ====#

func toggle_show_content():
	is_expanded = !is_expanded




#==== Tick ====#

func _process(delta):
	if abs(rect_size.y-rect_min_size.y) < 1: # snap to end
		rect_size.y = rect_min_size.y
	
	if is_expanded: # resize to target size
		rect_size.y = lerp(rect_size.y, i_card_count * (i_card_panel_height + i_card_gap_height), ease(i_scaling_speed, 1))
	else:
		rect_size.y = lerp(rect_size.y, rect_min_size.y, ease(i_scaling_speed, 1))
	if last_rect_size != rect_size: # update layout
		get_parent().update()
		last_rect_size = rect_size
		i_scaling_speed += 0.002
		if i_scaling_speed > 0.3:
			i_scaling_speed = 0.3
	else:
		i_scaling_speed = 0.002



#==== Logic ====#

func add_card(card_id, description, qty):
	var item_instance = c_vbox_item_prefab.instance()
	item_instance.initialize(self, card_id, description, qty)
	r_vbox_container.add_child(item_instance)
	i_card_count += 1


func remove_card(index):
	i_card_count -= 1
	r_vbox_container.get_child(index).queue_free()


func remove_all_cards():
	for child in r_vbox_container.get_children():
		i_card_count -= 1
		child.queue_free()


func shrink_panel():
	is_expanded = false
	rect_size.y = rect_min_size.y


