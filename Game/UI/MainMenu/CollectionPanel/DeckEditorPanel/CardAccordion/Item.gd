extends Control

#==== Components ====#
var _title_label
var _cost_label
var _value_label
var _hover_timer # instanced when the mouse enters the area on hover

#==== Bootstrap ====#

func initialize():
	_title_label = $TitleLabel
	_cost_label = $CostLabel
	_value_label = $ValueLabel



#==== Bootstrap ====#

func set_info(title, cost, value):
	_title_label.text = title
	_cost_label.text = cost
	_value_label.text = value



#==== UI Interaction ====#

func on_hover_entered():
	pass
#	_hover_timer = Timer()

func on_hover_exited():
	pass
#	_hov\er_timer = Timer()



#==== Component Management ====#

func create_hover_timer():
	pass





