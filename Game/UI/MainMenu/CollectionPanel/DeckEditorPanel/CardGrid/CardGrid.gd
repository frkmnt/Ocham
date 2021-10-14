extends Node

#==== Components ====#
onready var _grid_container = $ScrollContainer/GridContainer



func _ready():
	apply_correct_scale_to_children()



func apply_correct_scale_to_children():
	for card in _grid_container.get_children():
		print(card.rect_size)
		print(card.rect_min_size)
