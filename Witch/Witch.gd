extends KinematicBody2D

signal hurt

export (int) var move_speed := 300
export (int) var gravity := 2000
export (int) var jump_strength := 500


onready var hurt_box := $HurtBox

var velocity := Vector2(0, 500)
var direction := Vector2.ZERO

var last_frame_is_on_floor := false
var can_jump := false
var health := 1

func _physics_process(delta: float) -> void:
	if not is_on_floor() && last_frame_is_on_floor:
		$CoyoteTimer.start()
		
	direction = get_move_direction()
	
	if direction.length() > 0: 
		$AnimatedSprite.play("running")
		if $DustTimer.is_stopped(): $DustTimer.start()
	else: 
		$AnimatedSprite.play("idle")
		$DustTimer.stop()
	
	if direction.x > 0: $AnimatedSprite.flip_h = false
	if direction.x < 0: $AnimatedSprite.flip_h = true
	
	apply_movement(delta)
	apply_gravity(delta)
	apply_velocity(delta)
	
	if is_on_floor() && !last_frame_is_on_floor:
		$DustTimer.spawn_dust()
		$WalkAudioStreamPlayer.play()
	
	last_frame_is_on_floor = is_on_floor()
	
	
	if health <= 0:
		emit_signal("hurt")


func apply_movement(_delta: float) -> void:
	velocity.x = direction.x * move_speed
	
	if direction.y > 0:
		$CoyoteTimer.stop()
		$JumpBufferTimer.stop()
		velocity.y -= jump_strength
		$JumpAudioStreamPlayer.play()


func apply_gravity(delta: float) -> void:
	velocity.y = clamp(velocity.y + gravity * delta, -jump_strength, jump_strength)


func apply_velocity(_delta: float) -> void:
	velocity = move_and_slide(velocity, Vector2.UP)


func get_move_direction() -> Vector2: 
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		jump()
	)
	
func jump():
	var key_is_pressed = Input.is_action_just_pressed("ui_up")
	
	if is_on_floor() && !$JumpBufferTimer.is_stopped():
		$JumpBufferTimer.stop()
		return 1
	
	if key_is_pressed && is_on_floor():
		return 1
	
	if key_is_pressed && !$CoyoteTimer.is_stopped():
		return 1
	
	if key_is_pressed && not is_on_floor():
		$JumpBufferTimer.start()
	
	return 0


func _on_HurtBox_area_entered(hit_box: Area2D) -> void:
	if hurt_box.global_position.y > hit_box.global_position.y:
		return
	
	velocity.y -= jump_strength + velocity.y
	$DustTimer.spawn_dust()


func _on_DustTimer_timeout() -> void:
	if not is_on_floor():
		return
	
	$DustTimer.spawn_dust()
	$WalkAudioStreamPlayer.play()

func _on_HitBox_area_entered(area: Area2D) -> void:
	health -= 1
