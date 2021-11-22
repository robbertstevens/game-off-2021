extends Node2D


func play_animation(anim: String) -> void:
	$AnimatedSprite.play(anim)


func _on_DustTimer_timeout() -> void:
	if $AnimatedSprite.animation =="running":
		$DustTimer.spawn_dust()
