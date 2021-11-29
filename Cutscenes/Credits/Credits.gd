extends CutsceneLevel

onready var score_text_label = $CanvasLayer/HBoxContainer/VBoxContainer3/Label

func _ready() -> void:
	._ready()
	
	var txt = score_text_label.text
	
	score_text_label.text = txt.format({
		"amount": Util.total_score,
		"total": Util.max_score,
		"total_restarts": Util.total_restarts
	})


func _on_Button_pressed() -> void:
	next_level()
