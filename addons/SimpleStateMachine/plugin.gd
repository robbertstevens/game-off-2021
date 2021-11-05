tool
extends EditorPlugin

var StateMachine = preload("./StateMachine.gd")

func _enter_tree() -> void:
	add_custom_type(
		"SimpleStateMachine", 
		"Node", 
		StateMachine, 
		load("res://addons/SimpleStateMachine/icons8-flow-16.png")
	)


func _exit_tree() -> void:
	remove_custom_type("SimpleStateMachine")



