extends KinematicBody2D

export (int) var move_speed := 10

onready var fsm := $SimpleStateMachine


var velocity := Vector2.ZERO
var direction := Vector2.RIGHT

func _ready() -> void:
	fsm.change_state(fsm.State.Walking)


func _physics_process(delta: float) -> void:
	fsm.physics_process(delta)
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	match(direction): 
		Vector2.LEFT:
			if !$LeftFloorCheck.is_colliding():
				direction = Vector2.RIGHT
		Vector2.RIGHT:
			if !$RightFloorCheck.is_colliding():
				direction = Vector2.LEFT
	
	
	$StateLabel.text = fsm.get_current_state_label()
