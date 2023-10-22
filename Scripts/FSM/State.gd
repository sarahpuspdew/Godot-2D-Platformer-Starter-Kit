extends Node
class_name State

var next_state : State
var character : CharacterBody2D
var playback : AnimationNodeStateMachinePlayback


func enter():
	pass


func exit():
	pass


func state_process(delta):
	pass


func state_physics_process(delta):
	pass


func state_input(event : InputEvent):
	pass
