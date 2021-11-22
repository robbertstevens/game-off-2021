extends CanvasLayer

onready var level_score: Label = $GUI/VBoxContainer/LevelScoreContainer/ScoreTicker
onready var total_score: Label = $GUI/VBoxContainer/TotalScoreContainer/ScoreTicker

var player
var current_level

func _on_Root_level_score_updated(score) -> void:
	level_score.text = str(score)


func _on_Root_total_score_updated(score) -> void:
	total_score.text = str(score)


