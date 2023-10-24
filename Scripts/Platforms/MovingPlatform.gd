extends Node2D
class_name MovingPlatform

@export_enum("auto", "manual") var mode : String
@export var move_to : Vector2
@export var speed : float

var tween : Tween
var duration : float
var player_on_platform : bool = false


func _ready():
	duration = speed/4
	start_tween()


func start_tween():
	if mode == "auto":
		tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		tween.set_loops().set_parallel(false)
		tween.tween_property($AnimatableBody2D, "position", move_to, duration)
		tween.tween_property($AnimatableBody2D, "position", Vector2.ZERO, duration)
		$AnimationPlayer.play("on")
	
	if mode == "manual":
		if tween:
			tween.kill()
		tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	
		if player_on_platform:
			tween.set_loops().set_parallel(false)
			tween.tween_property($AnimatableBody2D, "position", move_to, duration)
			tween.tween_property($AnimatableBody2D, "position", Vector2.ZERO, duration)
			$AnimationPlayer.play("on")
		else:
			tween.tween_property($AnimatableBody2D, "position", Vector2.ZERO, duration)
			await tween.finished
			$AnimationPlayer.play("off")


func _on_area_2d_body_entered(body):
	player_on_platform = true
	start_tween()


func _on_area_2d_body_exited(body):
	player_on_platform = false
	start_tween()
