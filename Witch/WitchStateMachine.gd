extends StateMachine

enum State {
	Idle, Walking, Jumping, Falling
}


func _do_idle_state(delta: float) -> void:
	owner.velocity.y = owner.velocity.y + owner.gravity * delta


func _do_walking_state(delta: float) -> void: 
	var direction := Vector2.ZERO

	if Input.is_action_pressed("ui_right"): 
		direction.x  = 1
	if Input.is_action_pressed("ui_left"): 
		direction.x = -1

	if direction.length() <= 0:
		change_state(State.Idle)
		
	owner.velocity.x = direction.x * owner.move_speed



func _do_jumping_state(_delta: float) -> void: 
	owner.velocity.y = -owner.jump_strength
	
	change_state(State.Falling)


func _do_falling_state(delta: float) -> void:
	var direction := Vector2.ZERO

	if Input.is_action_pressed("ui_right"): 
		direction.x  = 1
	if Input.is_action_pressed("ui_left"): 
		direction.x = -1
		
	owner.velocity.x = direction.x * owner.move_speed
	owner.velocity.y = owner.velocity.y + owner.gravity * delta
	
	if owner.is_on_floor():
		change_state(State.Idle)


func get_states() -> Array: 
	return State.keys()
