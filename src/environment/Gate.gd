class_name Gate
extends Spatial

onready var anim = $AnimationPlayer

func _ready():
	pass

func open():
	anim.play("open")
