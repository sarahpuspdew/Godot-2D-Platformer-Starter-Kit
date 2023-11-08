extends PlayerState

# state
@export var double_jump_state : PlayerState
@export var dash_state : PlayerState
@export var fall_state : PlayerState
@export var hit_state : PlayerState

var jump_pressed : bool = false
var dash_pressed : bool = false


func enter():
	playback.travel("Jump")
	player.jump(player.jump_velocity)


func state_physics_process(delta):
	player.move(player.air_friction)
	
	if player.velocity.y < 0:
		if dash_pressed and player.can_dash:
			next_state = dash_state
		
		if jump_pressed and not player.has_double_jumped:
			next_state = double_jump_state
		
		if player.is_on_ceiling():
			next_state = fall_state
	else:
		next_state = fall_state

func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		jump_pressed = true
	if event.is_action_pressed("dash"):
		dash_pressed = true


func exit():
	jump_pressed = false
	dash_pressed = false


func _on_health_component_died():
	next_state = hit_state
