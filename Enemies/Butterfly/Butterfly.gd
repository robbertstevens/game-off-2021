extends KinematicBody2D


signal captured

export (int) var move_speed := 10

onready var fsm := $SimpleStateMachine
onready var hit_box := $HitBox

var velocity := Vector2.ZERO
var direction := Vector2.RIGHT

func _ready() -> void:
	fsm.change_state(fsm.State.Walking)
	add_to_group(Util.GROUP_BUGS)


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


func _on_HitBox_area_entered(hurt_box: Area2D) -> void:
	if hit_box.global_position.y < hurt_box.global_position.y:
		return
	
	emit_signal("captured")
	
	queue_free()
