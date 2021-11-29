extends KinematicBody2D


signal captured


onready var hit_box := $HitBox

export (int) var move_speed := 10

var velocity := Vector2.ZERO
var direction := Vector2.RIGHT

func _ready() -> void:
	add_to_group(Util.GROUP_BUGS)


func _physics_process(delta: float) -> void:
	velocity.x = direction.x * move_speed
	velocity = move_and_slide(velocity, Vector2.UP)
	
	match(direction): 
		Vector2.LEFT:
			if !$LeftFloorCheck.is_colliding():
				direction = Vector2.RIGHT
			if $LeftWallCheck.is_colliding():
				direction = Vector2.RIGHT
		Vector2.RIGHT:
			if !$RightFloorCheck.is_colliding():
				direction = Vector2.LEFT
			if $RightWallCheck.is_colliding():
				direction = Vector2.LEFT


func _on_HitBox_area_entered(hurt_box: Area2D) -> void:
	if hit_box.global_position.y < hurt_box.global_position.y:
		return
	
	emit_signal("captured")
	
	queue_free()
