extends StateMachine


enum State {
	Idle, Moving
}

func _do_idle_state(delta: float) -> void:
	if not owner.is_on_floor():
		change_state(State.Moving)
	
	if owner.get_move_direction().length() > 0:
		change_state(State.Moving)


func _do_moving_state(delta: float) -> void:
	owner.apply_gravity(delta)
	
	if owner.get_move_direction().length() == 0 && owner.is_on_floor():
		change_state(State.Idle)

	owner.apply_movement(owner.move_speed)	
	owner.apply_velocity(delta)



func get_states() -> Array:
	return State.keys()
