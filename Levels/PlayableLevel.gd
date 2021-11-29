extends Level


signal level_score_updated(new_score)


onready var start: Position2D = $Start
onready var player = $Witch
onready var exit = $Exit
onready var camera: Camera2D = $Camera

var max_level_score := 0

func _ready() -> void:
	._ready()
	
	player.global_position = start.global_position
	player.connect("hurt", self, "reload_level")
	
	camera.make_current()
	
	var bugs = get_tree().get_nodes_in_group(Util.GROUP_BUGS)
	
	max_level_score = bugs.size()
	
	for bug in bugs:
		bug.connect("captured", self, "_on_Bug_captured")
	
	connect("level_score_updated", $LevelUserInterface, "_on_Level_level_score_updated")


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


func set_level_score(new_value) -> void:
	level_score = new_value
	emit_signal("level_score_updated", level_score)


func _on_Bug_captured() -> void:
	set_level_score(level_score + 1)


func _on_Exit_area_entered(area: Area2D) -> void:
	Util.max_score += max_level_score
	Util.level_score = level_score
	next_level()
