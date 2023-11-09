extends Camera2D

@export var player : Player


func _process(delta):
	if player != null:
		position = player.position
	else:
		return
