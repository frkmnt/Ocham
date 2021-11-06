extends Node

#==== Components ====#
var _default_cursor = load("res://Assets/Graphics/InGame/Cursor/default.png")
var _targeting_cursor = load("res://Assets/Graphics/InGame/Cursor/targeting.png")

#==== Variables ====#
var _target_size = Vector2(64, 64)


#==== Bootstrap ====#

func _ready():
	set_default_cursor()


func set_default_cursor():
	Input.set_custom_mouse_cursor(_default_cursor, 0, Vector2(0, 0))

func set_targeting_cursor():
	Input.set_custom_mouse_cursor(_targeting_cursor, 0, _target_size)
	
