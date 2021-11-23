extends Node


onready var player := $Witch
onready var camera: Camera2D = $Camera
onready var exit = $Exit

func _ready() -> void:
	camera.make_current()


func _physics_process(delta: float) -> void:
	if player != null: 
		camera.global_position = player.global_position

	var tile_map = $TileMap

	if tile_map: 
		var bounds = TileMapBounds.from_tile_map(tile_map)
		camera.limit_left = bounds.limit_left
		camera.limit_right = bounds.limit_right
		camera.limit_top =  bounds.limit_top
		camera.limit_bottom = bounds.limit_bottom

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
