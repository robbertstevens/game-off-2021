extends KinematicBody2D

export (int) var move_speed := 300
export (int) var gravity := 2000
export (int) var jump_strength := 500

onready var fsm := $SimpleStateMachine

var velocity := Vector2(0, 500)

var last_frame_is_on_floor := is_on_floor()

func _ready() -> void:
	fsm.change_state(fsm.State.Idle)

func _physics_process(delta: float) -> void:
	fsm.physics_process(delta)
	
	last_frame_is_on_floor = is_on_floor()
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if !is_on_floor() && last_frame_is_on_floor:
		$CoyoteTimer.start()
	
	if !is_on_floor():
		fsm.change_state(fsm.State.Falling)


func _input(event: InputEvent) -> void:
	if _is_move_input(event) || fsm.is_state(fsm.State.Walking): 
		fsm.change_state(fsm.State.Walking) 
		
	if event.is_action_pressed("ui_accept") && _is_floored():
		$CoyoteTimer.stop()
		fsm.change_state(fsm.State.Jumping)


func _is_move_input(event: InputEvent) -> bool:
	return event.is_action("ui_right") || event.is_action("ui_left") || event.is_action("ui_down") || event.is_action("ui_up")


func _is_floored() -> bool: 
	return is_on_floor() || !$CoyoteTimer.is_stopped()
