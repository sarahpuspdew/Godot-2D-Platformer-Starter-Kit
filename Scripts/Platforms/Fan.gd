extends Area2D
class_name Fan

@export var force : float
var is_on : bool = false


func _ready():
	$TurnOffTimer.start()


func _process(delta):
	if is_on:
		$AnimationPlayer.play("on")
	else:
		$AnimationPlayer.play("off")


func _on_body_entered(body):
	if body is Player:
		var player = body as Player
		
		if is_on:
			player.velocity.y = force
			player.gravity = 0


func _on_body_exited(body):
	if body is Player:
		var player = body as Player
		
		player.gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _on_turn_on_timer_timeout():
	is_on = true
	$TurnOffTimer.start()


func _on_turn_off_timer_timeout():
	is_on = false
	$TurnOnTimer.start()
