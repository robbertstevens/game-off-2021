extends Node2D


export (Array, PackedScene) var levels := []

var level_list := []
var current_level_scene = null
var current_level = null


func _ready():
	reset()
	next_level()


func next_level() -> void:
	Util.total_score += Util.level_score
	
	var level = level_list.pop_front()
	
	if not level:
		reset()
		next_level()
	else:
		load_level(level)


func reload_level() -> void:
	load_level(current_level_scene)


func load_level(level: PackedScene):
	var level_score = 0
	if current_level:
		level_score = current_level.level_score
		var previous_level = current_level
		remove_child(previous_level)
		previous_level.queue_free()
		
	
	current_level_scene = level
	current_level = level.instance()
	
	if (Util.object_has_signal(current_level, "next_level")): 
		current_level.connect("next_level", self, "next_level")
	
	if (Util.object_has_signal(current_level, "reload_level")):
		current_level.connect("reload_level", self, "reload_level")
	
	if "ingredients" in current_level:
		print(level_score)
		current_level.ingredients = level_score
	
	call_deferred("add_child", current_level)


func reset() -> void:
	level_list = levels.duplicate()
	Util.total_score = 0
	Util.level_score = 0
	Util.max_score = 0
	Util.total_restarts = 0
