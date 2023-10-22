extends CharacterBody2D
class_name Player

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : float
var last_direction : float

# movement
@export var current_speed : float
@export var max_speed : float
@export var acceleration : float
@export var decceleration : float
@export var air_friction : float

# dash
@export var dash_speed : float
@export var dash_duration : float
var can_dash : bool = true

# jump
@export var jump_velocity : float
@export var double_jump_velocity : float
@export var wall_jump_velocity : float
var has_double_jumped : bool = false

# wall
@export var wall_slide_speed : float
@export var wall_jump_pushback : float


func _ready():
	$AnimationTree.active = true


func _physics_process(delta):
	get_direction()
	apply_gravity(delta)
	move_and_slide()


func get_direction():
	direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if direction != 0:
		last_direction = direction
	
	$AnimationTree.set("parameters/move/blend_position", direction)
	
	if direction > 0 :
		$Sprite2D.scale.x = 1
	elif direction < 0:
		$Sprite2D.scale.x = -1


func apply_gravity(delta):
	if $PlayerStateMachine.current_state != $PlayerStateMachine/Dash:
		velocity.y += gravity * delta


func move(subtractor):
	current_speed = move_toward(current_speed, max_speed - subtractor, acceleration)
	velocity.x = current_speed * direction


func jump(jump_power):
	velocity.y = 0
	velocity.y = jump_power
	can_dash = true
