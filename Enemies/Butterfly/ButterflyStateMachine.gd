extends StateMachine

enum State { Idle, Walking }


func _do_idle_state(delta: float) -> void: 
	change_state(State.Walking)


func _do_walking_state(delta: float) -> void:
	var direction = owner.direction
		
	owner.velocity.x = direction.x * owner.move_speed


func get_states() -> Array: 
	return State.keys()
