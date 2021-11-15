class_name StateMachine

extends Node

var current_state: int
var previous_state: int

func _ready() -> void:
	yield(owner, "ready")


"""
run this in your _input() method
"""
func input(event: InputEvent) -> void:
	pass
	
"""
Changes the state of the Finate State Machine only when the state is different 
from the state it is currently in.
"""
func change_state(new_state: int) -> void:
	if not current_state == new_state:
		previous_state = current_state
		current_state = new_state


func physics_process(delta: float) -> void:
	var state_name = get_states()[current_state]
	var state_method = ("_do_" + state_name + "_state").to_lower()
	call(state_method, delta)


func is_state(state: int) -> bool: 
	return current_state == state


func get_current_state_label() -> String: 
	return get_states()[current_state]

"""
Gets the list of states available in the statemachine. If you use an enum to define states, you can 
return `States.keys()`
@return Array<string>
"""
func get_states() -> Array:
	assert(false)
	return []
