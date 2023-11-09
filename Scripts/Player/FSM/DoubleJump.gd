extends PlayerState

# state
@export var dash_state : PlayerState
@export var fall_state : PlayerState
@export var hit_state : PlayerState

var dash_pressed : bool = false


func enter():
	player.has_double_jumped = true
	playback.travel("Double_Jump")
	player.jump(player.double_jump_velocity)


func state_physics_process(delta):
	player.move(player.air_friction)
	
	if player.velocity.y < 0:
		if player.is_on_ceiling():
			next_state = fall_state
		
		if dash_pressed and player.can_dash:
			next_state = dash_state
		
	else:
		next_state = fall_state


func state_input(event : InputEvent):
	if event.is_action_pressed("dash"):
		dash_pressed = true


func exit():
	dash_pressed = false


func _on_health_component_died():
	next_state = hit_state
