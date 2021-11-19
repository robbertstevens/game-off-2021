extends CanvasLayer

onready var level_score: Label = $GUI/VBoxContainer/LevelScoreContainer/ScoreTicker
onready var total_score: Label = $GUI/VBoxContainer/TotalScoreContainer/ScoreTicker

var player
var current_level

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if player: 
		$Maincamera.global_position = player.global_position
		
	if current_level:
		var tile_map = current_level.get_node("TileMap")
		
		var bounds = TileMapBounds.from_tile_map(tile_map)
		
		$Maincamera.limit_left = bounds.limit_left
		$Maincamera.limit_right = bounds.limit_right
		$Maincamera.limit_top =  bounds.limit_top
		$Maincamera.limit_bottom = bounds.limit_bottom


func _on_Root_level_score_updated(score) -> void:
	level_score.text = str(score)


func _on_Root_total_score_updated(score) -> void:
	total_score.text = str(score)


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
