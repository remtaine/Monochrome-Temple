class_name Level
extends Node

func _ready():
	pass

func _unhandled_input(event):
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()
