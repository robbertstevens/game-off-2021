class_name StateMachine

extends Node

var current_state: int
var previous_state: int

func _ready() -> void:
	yield(owner, "ready")

	
"""
Changes the state of the Finate State Machine only when the state is different 
from the state it is currently in.
"""
func change_state(new_state: int) -> void:
	if not current_state == new_state:
		previous_state = current_state
		current_state = new_state


func physics_process(delta: float) -> void:
	pass

func is_state(state: int) -> bool: 
	return current_state == state
