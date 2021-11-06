extends AnimatedSprite


#==== Events ====#

func on_anim_finished():
	stop()
	set_frame(0)


