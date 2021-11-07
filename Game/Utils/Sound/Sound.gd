extends AudioStreamPlayer


func _ready():
  stream.loop = false


func on_finished():
	stop()
