extends StateMachine

enum State {
	Idle, Walking, Jumping, Air
}

onready var animation_player: AnimationPlayer = owner.get_node("AnimationPlayer")

func physics_process(delta: float) -> void:
	.physics_process(delta)
#	print(get_current_state_label())


func _do_idle_state(delta: float) -> void:
	animation_player.play("Idle")
	owner.velocity.y = owner.velocity.y + owner.gravity * delta


func _do_walking_state(delta: float) -> void: 
	if owner.direction.length() == 0:
		change_state(State.Idle)
		return
	animation_player.play("Walking")


func _do_jumping_state(_delta: float) -> void:
	owner.velocity.y = -owner.jump_strength
	change_state(State.Air)


func _do_air_state(delta: float) -> void:
	if owner.is_on_floor():
		change_state(State.Idle)


func get_states() -> Array: 
	return State.keys()
