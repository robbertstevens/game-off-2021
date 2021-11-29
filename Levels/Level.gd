class_name Level

extends Node


signal next_level
signal reload_level

var level_score := 0


func _ready() -> void:
	Util.level_score = 0


func next_level() -> void:
	emit_signal("next_level")
	queue_free()


func reload_level() -> void:
	Util.total_restarts += 1
	emit_signal("reload_level")
	queue_free()


class TileMapBounds:
	var limit_left
	var limit_right
	var limit_top
	var limit_bottom
	
	static func from_tile_map(tile_map: TileMap) -> TileMapBounds:
		var map_limits = tile_map.get_used_rect()
		var map_cellsize = tile_map.cell_size
		var bounds = TileMapBounds.new()
		
		bounds.limit_left = map_limits.position.x * map_cellsize.x
		bounds.limit_right = map_limits.end.x * map_cellsize.x
		bounds.limit_top = map_limits.position.y * map_cellsize.y
		bounds.limit_bottom = map_limits.end.y * map_cellsize.y
		
		return bounds
