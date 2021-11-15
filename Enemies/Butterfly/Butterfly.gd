extends KinematicBody2D

export (int) var move_speed := 10

onready var fsm := $SimpleStateMachine
onready var hit_box := $HitBox

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


func _on_HitBox_area_entered(hurt_box: Area2D) -> void:
	print(hit_box.global_position, hurt_box.global_position)
	print(hit_box.global_position.y > hurt_box.global_position.y)
	if hit_box.global_position.y < hurt_box.global_position.y:
		return
		
	print("I got hurt")
	
	queue_free()
