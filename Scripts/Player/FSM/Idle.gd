extends PlayerState

# state
@export var run_state : PlayerState
@export var jump_state : PlayerState
@export var dash_state : PlayerState
@export var hit_state : PlayerState


func enter():
	playback.travel("Idle")


func state_physics_process(delta):
	if player.direction != 0:
		next_state = run_state
	
	player.velocity.x = move_toward(player.velocity.x, 0, player.decceleration)


func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		next_state = jump_state
	if event.is_action_pressed("dash"):
		next_state = dash_state


func exit():
	player.current_speed = 0


func _on_health_component_died():
	next_state = hit_state
