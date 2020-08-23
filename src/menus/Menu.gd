class_name Menu
extends Node2D

onready var level_path = "res://src/levels/Level1.tscn"
onready var flash = $CanvasLayer/Control/StartLabel/AnimationPlayer
func _ready():
#	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	flash.playback_speed = 0.5

func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.scancode == KEY_SPACE:
			change_scene()

func change_scene():
	flash.playback_speed = 4
	yield(get_tree().create_timer(1), "timeout")		
	get_tree().change_scene(level_path)
