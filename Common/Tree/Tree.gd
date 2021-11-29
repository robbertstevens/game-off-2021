extends AnimatedSprite

func _ready() -> void:
	randomize()
	
	var animations_frames = frames.get_frame_count("default")
	var f = randi() % animations_frames
	
	frame = f
