extends Node
class_name CharacterStateMachine

@export var character : CharacterBody2D
@export var animation_tree : AnimationTree
@export var current_state : State

var states : Array[State]


func _ready():
	for child in get_children():
		if child is State:
			states.append(child)
			
			# Set the states up with what they need to function
			child.character = character
			child.playback = animation_tree["parameters/playback"]
			
		else:
			push_warning("Child " + child.name + " is not a State for the characterStateMachine")


func _process(delta):
	if current_state.next_state != null:
		switch_state(current_state.next_state)
	
	current_state.state_process(delta)


func _physics_process(delta):
	if current_state.next_state != null:
		switch_state(current_state.next_state)
	
	current_state.state_physics_process(delta)


func switch_state(new_state : State):
	if current_state != null:
		current_state.exit()
		current_state.next_state = null
		
	current_state = new_state
	current_state.enter()


func _input(event : InputEvent):
	current_state.state_input(event)
