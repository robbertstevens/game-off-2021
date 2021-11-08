extends KinematicBody2D

export (int) var move_speed := 300
export (int) var gravity := 2000
export (int) var jump_strength := 500

onready var fsm := $SimpleStateMachine

var velocity := Vector2(0, 500)
var direction := Vector2.ZERO

var last_frame_is_on_floor := false

func _ready() -> void:
	last_frame_is_on_floor = is_on_floor()
	fsm.change_state(fsm.State.Idle)

func _physics_process(delta: float) -> void:
	fsm.physics_process(delta)
	
	$StateLabel.text = fsm.get_current_state_label()
	
	if !is_on_floor() && last_frame_is_on_floor:
		$CoyoteTimer.start()

	if _is_floored() && !$JumpBufferTimer.is_stopped():
		$JumpBufferTimer.stop()
		fsm.change_state(fsm.State.Air)

	apply_movement(move_speed)
	apply_gravity(delta)
	apply_velocity()
	
	last_frame_is_on_floor = is_on_floor()
	

func _input(event: InputEvent) -> void:
	if _is_move_input(event) && _is_floored():
		fsm.change_state(fsm.State.Walking)
		
	if event.is_action_pressed("ui_accept") && _is_floored():
		$CoyoteTimer.stop()
		fsm.change_state(fsm.State.Jumping)

	if event.is_action_pressed("ui_accept") && !_is_floored():
		$JumpBufferTimer.start()
 
func _is_move_input(event: InputEvent) -> bool:
	return event.is_action("ui_right") || event.is_action("ui_left") || event.is_action("ui_down") || event.is_action("ui_up")


func _is_floored() -> bool: 
	return is_on_floor() || !$CoyoteTimer.is_stopped()


func apply_movement(speed) -> void:
	direction = get_move_direction()
	velocity.x = direction.x * speed


func apply_gravity(delta: float) -> void:
	velocity.y = velocity.y + gravity * delta


func apply_velocity() -> void:
	velocity = move_and_slide(velocity, Vector2.UP)


func get_move_direction() -> Vector2: 
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		0
	)
