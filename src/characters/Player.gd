class_name Player
extends Character

var is_flipped : bool = false

onready var tween
onready var sprite = $Pivot/Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	change_direction("move_forward")

func change_direction(dir):
	sprite.play(dir)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
