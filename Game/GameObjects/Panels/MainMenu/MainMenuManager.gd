extends Control

#==== Class Comments ====#
# Aliases: mp -> main panel, mc -> main card collection, de -> deck editor

#==== Components ====#
onready var _mp = $MainPanel
onready var _mc = $MainCollectionPanel
onready var _de = $DeckEditorPanel


#==== Bootstrap ====#

func _ready():
	pass


#==== MP ====#

func on_mp_play_button_clicked():
	print("TODO: Implement Play Menu")

func on_mp_collection_button_clicked():
	_mp.visible = false
	_mc.visible = true


#==== CC ====#

func on_mc_deck_clicked():
	_de.initialize([0, 0, 1, 1, 2, 2])
	_de.on_open()
	_mc.visible = false

func on_mc_back_button_clicked():
	_mc.visible = false
	_mp.visible = true



#==== DE ====#

func on_de_back_button_clicked():
	_de.visible = false
	_mc.visible = true




