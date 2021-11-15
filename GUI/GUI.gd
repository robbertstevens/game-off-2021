extends Control

var player
var current_level

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if player: 
		$Maincamera.global_position = player.global_position
		
	if current_level:
		var tileMap = current_level.get_node("TileMap")
		
		var map_limits = tileMap.get_used_rect()
		var map_cellsize = tileMap.cell_size
		$Maincamera.limit_left = map_limits.position.x * map_cellsize.x
		$Maincamera.limit_right = map_limits.end.x * map_cellsize.x
		$Maincamera.limit_top = map_limits.position.y * map_cellsize.y
		$Maincamera.limit_bottom = map_limits.end.y * map_cellsize.y
