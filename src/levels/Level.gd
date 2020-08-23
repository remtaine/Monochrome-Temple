class_name Level
extends Node

onready var menu_path = "res://src/menus/MainMenu.tscn"
onready var death_menu_anim = $HUD/DeathMenu/AnimationPlayer
onready var win_menu_anim = $HUD/WinMenu/AnimationPlayer
var game_decided = false

func _ready():
	add_to_group("levels")
	get_tree().call_group("enemies","set_target", $Characters/Player)

func _unhandled_input(event):
	if game_decided:
		if event.is_action_pressed("reset"):
			get_tree().reload_current_scene()
		if event.is_action_pressed("menu"):
			get_tree().change_scene(menu_path)

func show_death_menu():
	death_menu_anim.play("appear")
	game_decided = true
	
func show_win_menu():
	$Gate.open()
	win_menu_anim.play("appear")
	game_decided = true	
