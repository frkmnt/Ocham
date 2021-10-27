extends Panel

#==== Components ====#
onready var _vbox_container = $VBoxContainer

#==== Constants ====#
const i_card_panel_height = 50 # //TODO add to env 
const i_card_gap_height = 0

#==== Variables ====#
var is_expanded = false
var last_rect_size = Vector2.ZERO
var card_count = 0
var scaling_speed = 0.002




#==== Bootstrap ====#

func initialize(parent_menu):
	shrink_panel()




#==== Logic ====#

func toggle_show_content():
	is_expanded = !is_expanded




#==== Animation ====#

func _process(delta):
	if abs(rect_size.y-rect_min_size.y) < 1: # snap to end
		rect_size.y = rect_min_size.y
	
	if is_expanded: # resize to target size
		rect_size.y = lerp(rect_size.y, card_count * (i_card_panel_height + i_card_gap_height), ease(scaling_speed, 1))
	else:
		rect_size.y = lerp(rect_size.y, rect_min_size.y, ease(scaling_speed, 1))
	if last_rect_size != rect_size: # update layout
		get_parent().update()
		last_rect_size = rect_size
		scaling_speed += 2 * delta
		if scaling_speed > 0.3:
			scaling_speed = 0.3
	else:
		scaling_speed = 0.002

func shrink_panel():
	is_expanded = false
	rect_size.y = rect_min_size.y




#==== Card Management ====#

func add_card(card_data):
	var accordion_item = ObjectFactory.instance_accordion_item()
	_vbox_container.add_child(accordion_item)
	accordion_item.set_info(card_data.card_name, card_data.cost, card_data.value)
	card_count += 1


func remove_card(index):
	card_count -= 1
	_vbox_container.get_child(index).queue_free()


func remove_all_cards():
	for child in _vbox_container.get_children():
		card_count -= 1
		child.queue_free()




