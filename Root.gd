extends Node2D

signal level_score_updated(new_score)
signal total_score_updated(new_score)


export (Array, PackedScene) var levels := []


var total_score := 0 setget set_total_score
var level_score := 0 setget set_level_score
var level_list := []
var current_level = null




func _ready():
	connect("level_score_updated", Gui, "_on_Root_level_score_updated")
	connect("total_score_updated", Gui, "_on_Root_total_score_updated")
	
	level_list = levels

	next_level()

func next_level() -> void:
	self.total_score += level_score
	self.level_score = 0
	
	if current_level:
		current_level.queue_free()
		
	var level = level_list.pop_front()
	
	current_level = level.instance()
	Gui.current_level = current_level
	
	add_child(current_level)
	for bug in get_all_bugs():
		bug.connect("captured", self, "_on_Bug_captured")


func get_all_bugs() -> Array:
	return get_tree().get_nodes_in_group(Util.GROUP_BUGS)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		next_level()


func _on_Bug_captured() -> void:
	self.level_score += 1


func set_level_score(new_value) -> void:
	level_score = new_value
	emit_signal("level_score_updated", level_score)


func set_total_score(new_value) -> void:
	total_score = new_value
	emit_signal("total_score_updated", total_score)
