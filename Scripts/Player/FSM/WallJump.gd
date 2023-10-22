extends PlayerState

# state
@export var fall_state : PlayerState
@export var double_jump_state : PlayerState

var jump_pressed : bool = false


func enter():
	playback.travel("Jump")
	player.jump(player.wall_jump_velocity)
	#player.velocity.x += player.wall_jump_pushback * player.last_direction


func state_physics_process(delta):
	player.move(player.air_friction)
	
	if player.velocity.y < 0:
		if jump_pressed and not player.has_double_jumped:
			next_state = double_jump_state
		
		if player.is_on_ceiling():
			next_state = fall_state
	else:
		next_state = fall_state


func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		jump_pressed = true


func exit():
	jump_pressed = false
	player.can_dash = true
