extends CanvasLayer

onready var level_score_ticker = $GUI/VBoxContainer/LevelScoreContainer/ScoreTicker
onready var score_ticker = $GUI/VBoxContainer/LevelScoreContainer/ScoreTicker

func _on_Level_level_score_updated(score) -> void:
	level_score_ticker.text = str(score)
