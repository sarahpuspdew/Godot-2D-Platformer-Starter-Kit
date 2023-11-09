extends StaticBody2D
class_name Trampoline

@export var force : float


func _on_area_2d_body_entered(body):
	if body is Player:
		var player = body as Player
		
		player.was_platform_jumped = true
		player.jump(force)
		$AnimationPlayer.play("jump")
