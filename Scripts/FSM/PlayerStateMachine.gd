extends Node
class_name PlayerStateMachine

@export var player : Player
@export var animation_tree : AnimationTree
@export var current_state : PlayerState

var states : Array[PlayerState]


func _ready():
	for child in get_children():
		if child is PlayerState:
			states.append(child)
			
			# Set the states up with what they need to function
			child.player = player as Player
			child.playback = animation_tree["parameters/playback"]
			
		else:
			push_warning("Child " + child.name + " is not a State for the playerStateMachine")


func _process(delta):
	if current_state.next_state != null:
		switch_state(current_state.next_state)
	
	current_state.state_process(delta)


func _physics_process(delta):
	if current_state.next_state != null:
		switch_state(current_state.next_state)
	
	current_state.state_physics_process(delta)


func switch_state(new_state : PlayerState):
	if current_state != null:
		current_state.exit()
		current_state.next_state = null
		
	current_state = new_state
	current_state.enter()


func _input(event : InputEvent):
	current_state.state_input(event)
