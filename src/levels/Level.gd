class_name Level
extends Node

onready var menu_path = "res://src/menus/MainMenu.tscn"

func _ready():
	get_tree().call_group("enemies","set_target", $Characters/Player)

func _unhandled_input(event):
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()
	if event.is_action_pressed("menu"):
		get_tree().change_scene(menu_path)
