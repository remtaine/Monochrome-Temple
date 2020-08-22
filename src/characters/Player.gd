class_name Player
extends Character

var is_flipped : bool = false

onready var tween
onready var sprite = $Sprite
onready var pivot = $Pivot
onready var camera = $Addons/Camera

# Called when the node enters the scene tree for the first time.
func _ready():
	change_direction("move_forward")

func change_direction(dir):
	sprite.play(dir)

func _physics_process(delta):
	var dropPlane  = Plane(Vector3(0, 0, 1), 0)
	var position3D = dropPlane.intersects_ray(
							 camera.project_ray_origin(get_viewport().get_mouse_position()),
							 camera.project_ray_normal(get_viewport().get_mouse_position())
	)
	if position3D != null:
		pivot.look_at(position3D,Vector3.UP)
#	pivot.look_at(get_viewport().get_mouse_position(), Vector3.UP)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
