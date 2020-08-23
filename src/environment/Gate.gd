class_name Gate
extends Spatial

onready var anim = $AnimationPlayer

func _ready():
	pass

func open():
	anim.playback_speed = 0.5
	anim.play("open")
