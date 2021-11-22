extends AnimatedSprite
func _ready() -> void:
	playing = true


func _on_Dust_animation_finished() -> void:
	queue_free()
