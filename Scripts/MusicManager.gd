extends AudioStreamPlayer2D

var muted = false

func mute_music():
	if(muted):
		play()
	else:
		stop()
	muted = !muted

func get_if_muted():
	return muted