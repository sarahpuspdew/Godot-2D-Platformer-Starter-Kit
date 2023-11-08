extends PlayerState

@export var sprite : Sprite2D

# state
@export var run_state : PlayerState
@export var fall_state : PlayerState
@export var hit_state : PlayerState

var dash_start_time : float
var elapsed_dash_time : float
var dash_direction : int


func enter():
	dash_direction = player.last_direction
	dash_start_time = Time.get_ticks_msec()
	
	player.velocity = Vector2.ZERO
	
	playback.travel("Idle")
	sprite.modulate = Color.FIREBRICK


func state_physics_process(delta):
	elapsed_dash_time = Time.get_ticks_msec() - dash_start_time
	
	player.velocity.x += player.dash_speed * dash_direction
	
	if elapsed_dash_time > player.dash_duration:
		if player.is_on_floor():
			next_state = run_state
		else:
			next_state = fall_state


func exit():
	player.velocity = Vector2.ZERO
	
	if not player.is_on_floor():
		player.can_dash = false
	
	sprite.modulate = Color.WHITE


func _on_health_component_died():
	next_state = hit_state
