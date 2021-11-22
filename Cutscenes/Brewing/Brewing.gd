extends Node2D


signal ingredients_mixed


var ingredient = preload("res://Common/Ingredient/Ingredient.tscn")

var ingredients := 2
var throw_ingredients := false


func _ready() -> void:
	$Camera.make_current()
	$AnimationPlayer.play("WalkingToPot")


func next_level() -> void:
	emit_signal("ingredients_mixed")
	queue_free()


func play_pot_animation(anim: String) -> void:
	$Pot.play(anim)


func _on_ThrowTimer_timeout() -> void:
	if ingredients > 0: 
		var i = ingredient.instance()
	
		$IngredientPath.add_child(i)
		
		ingredients -= 1
	else: 
		$AnimationPlayer.play("MixPot")
		$ThrowTimer.stop()
