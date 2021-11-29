extends CutsceneLevel

onready var animation_player := $AnimationPlayer

var ingredient = preload("res://Common/Ingredient/Ingredient.tscn")

var ingredients := 0
var throw_ingredients := false


func _ready() -> void:
	._ready()
	animation_player.play("WalkingToPot")


func play_pot_animation(anim: String) -> void:
	$Pot.play(anim)


func decide_if_throw_or_mix_animation_has_to_be_played() -> void:
	if ingredients > 0:
		animation_player.play("ThrowingInPot")
		$ThrowTimer.start()
	else: 
		animation_player.play("MixPot")


func _on_ThrowTimer_timeout() -> void:
	if ingredients > 0: 
		var i = ingredient.instance()
	
		$IngredientPath.add_child(i)
		
		ingredients -= 1
	else: 
		animation_player.play("MixPot")
		$ThrowTimer.stop()
