extends Control

#==== Components ====#
onready var _name_label = $TitleLabel
onready var _cost_label = $CostLabel
onready var _value_label = $ValueLabel
var _hover_timer # instanced when the mouse enters the area on hover


#==== Bootstrap ====#

func set_info(name, cost, value):
	_name_label.text = name
	_cost_label.text = str(cost)
	_value_label.text = str(value)



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





