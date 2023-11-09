extends PlayerState

# state
@export var idle_state : PlayerState
@export var fall_state : PlayerState
@export var wall_jump_state : PlayerState
@export var hit_state : PlayerState

var jump_pressed : bool = false


func enter():
	playback.travel("Wall_Slide")


func state_physics_process(delta):
	player.move(0)
	player.velocity.y = player.wall_slide_speed
	
	if player.is_on_wall() and not player.is_on_floor():
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			next_state = self
		else:
			next_state = fall_state
	else:
		next_state = fall_state
	
	if jump_pressed:
		next_state = wall_jump_state

	if player.is_on_floor():
		next_state = idle_state


func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		jump_pressed = true


func exit():
	jump_pressed = false
	player.has_double_jumped = false


func _on_health_component_died():
	next_state = hit_state
