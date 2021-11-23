extends Node2D

signal level_score_updated(new_score)
signal total_score_updated(new_score)


export (Array, PackedScene) var levels := []
export (PackedScene) var transition_level


var max_total_score := 0
var total_score := 0 setget set_total_score
var level_score := 0 setget set_level_score
var level_list := []
var current_level = null


func _ready():
	connect("level_score_updated", Gui, "_on_Root_level_score_updated")
	connect("total_score_updated", Gui, "_on_Root_total_score_updated")
	
	level_list = levels.duplicate()
	self.total_score = 0
	self.level_score = 0
	
	next_level()

func next_level() -> void:
	if current_level:
		current_level.queue_free()
	
	var level = level_list.pop_front()
	
	if not level:
		play_credits()
		return
	
	current_level = level.instance()
	Gui.current_level = current_level
	
	add_child(current_level)
	
	for bug in get_all_bugs():
		bug.connect("captured", self, "_on_Bug_captured")
	
	current_level.exit.connect('area_entered', self, "_on_Exit_area_entered")

func get_all_bugs() -> Array:
	return get_tree().get_nodes_in_group(Util.GROUP_BUGS)


func _on_Bug_captured() -> void:
	self.level_score += 1


func set_level_score(new_value) -> void:
	level_score = new_value
	emit_signal("level_score_updated", level_score)


func set_total_score(new_value) -> void:
	total_score = new_value
	emit_signal("total_score_updated", total_score)


func play_cut_scene() -> void:
	var cut_scene = transition_level.instance()
	
	cut_scene.connect("ingredients_mixed", self, "_on_Brewing_ingredients_mixed")
	cut_scene.ingredients = level_score
	
	self.total_score += level_score
	self.level_score = 0
	
	if current_level:
		current_level.queue_free()
	
	current_level = cut_scene
	add_child(cut_scene)


func _on_Brewing_ingredients_mixed() -> void:
	next_level()
	

func _on_Exit_area_entered(area: Area2D) -> void:
	play_cut_scene()


func play_credits() -> void:
	reset()
	next_level()


func reset() -> void:
	level_list = levels.duplicate()
	self.total_score = 0
	self.level_score = 0
