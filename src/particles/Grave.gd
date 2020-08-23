class_name Grave
extends KinematicBody

var velocity = Vector3.ZERO

func _ready():
	pass

func _physics_process(delta):
	velocity += Vector3.DOWN * 1
	move_and_collide(velocity * delta)
