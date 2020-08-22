extends KinematicBody

var direction : Vector3
var velocity : Vector3 = Vector3.ZERO
var speed = 8

func _ready():
	pass

func setup(pos, dir):
	global_transform.origin = pos
	direction = dir
	velocity = direction * speed
	
func _physics_process(delta):
	move_and_slide(velocity, Vector3.UP)
