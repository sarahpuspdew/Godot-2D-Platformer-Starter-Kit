extends PlayerState


func enter():
	player.velocity = Vector2.ZERO
	playback.travel("Hit")
