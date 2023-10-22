extends PlayerState

# state
@export var idle_state : PlayerState
@export var jump_state : PlayerState
@export var dash_state : PlayerState
@export var fall_state : PlayerState

var can_jump : bool = true
var jumping : bool = false
var coyote : bool = false
var was_in_floor : bool = false


func enter():
	playback.travel("Run")


func state_physics_process(delta):
	if not player.is_on_floor() and was_in_floor and not jumping:
		$CoyoteTimer.start()
		
	if not can_jump:
		next_state = fall_state
	
	was_in_floor = player.is_on_floor()
	
	if player.direction == 0:
		next_state = idle_state
	else:
		player.move(0)


func state_input(event : InputEvent):
	if event.is_action_pressed("jump") or coyote:
		jumping = true
		next_state = jump_state
	if event.is_action_pressed("dash"):
		next_state = dash_state


func exit():
	player.current_speed = 0
	jumping = false
	can_jump = true


func _on_coyote_timer_timeout():
	can_jump = false
	coyote = false
