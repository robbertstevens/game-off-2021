extends Timer

export (PackedScene) var dust_cloud

func spawn_dust() -> void:
	var dust = dust_cloud.instance()
	dust.global_position = owner.global_position
	get_tree().get_root().add_child(dust)
