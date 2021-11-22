extends PathFollow2D

func _process(delta: float) -> void:
	unit_offset += delta
	
	if unit_offset >= 1:
		queue_free()
