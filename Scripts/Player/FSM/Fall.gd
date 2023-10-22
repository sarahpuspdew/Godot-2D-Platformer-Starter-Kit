extends PlayerState

# state
@export var double_jump_state : PlayerState
@export var wall_slide_state : PlayerState
@export var dash_state : PlayerState
@export var run_state : PlayerState

var jump_pressed : bool = false
var dash_pressed : bool = false


func enter():
	playback.travel("Fall")


func state_physics_process(delta):
	player.move(player.air_friction)
	
	if jump_pressed and not player.has_double_jumped:
			next_state = double_jump_state
	
	if dash_pressed and player.can_dash:
		next_state = dash_state
	
	if player.is_on_floor():
		next_state = run_state
		player.has_double_jumped = false
	
	if player.is_on_wall():
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			next_state = wall_slide_state


func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		jump_pressed = true
	if event.is_action_pressed("dash"):
		dash_pressed = true


func exit():
	jump_pressed = false
	dash_pressed = false
