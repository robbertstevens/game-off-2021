extends Node2D

export (Array, PackedScene) var levels := []

var total_score := 0

var level_score := 0

var level_list := []

var current_level = null

func _ready():
	level_list = levels
	
	next_level()


func next_level() -> void:
	total_score += level_score
	
	if current_level:
		current_level.queue_free()
		
	var level = level_list.pop_front()
	
	current_level = level.instance()
	
	add_child(current_level)
	
	Gui.current_level = current_level


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		next_level()
