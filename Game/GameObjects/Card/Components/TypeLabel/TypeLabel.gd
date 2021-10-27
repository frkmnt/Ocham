extends Control


#==== Variables ====#
export var _type = "Active"
onready var _label = $Label


func _ready():
	_label.text = _type


