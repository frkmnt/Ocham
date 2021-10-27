extends Node

#==== Components ====#
onready var _fade_tween = $FadeTween


#==== Glow ====#

func apply_glow():
	var new_color = self.modulate
	new_color.a = 1.0
	_fade_tween.interpolate_property(self, "modulate", self.modulate, new_color, 
		0.1, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR, 0)
	_fade_tween.start()

func cancel_glow():
	var new_color = self.modulate
	new_color.a = 0.0
	_fade_tween.interpolate_property(self, "modulate", self.modulate, new_color, 
		0.1, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR, 0)
	_fade_tween.start()
