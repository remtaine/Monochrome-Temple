class_name Fireball
extends KinematicBody

var direction : Vector3
var velocity : Vector3 = Vector3.ZERO
export var speed = 8
var owned_by = null
onready var sprite = $Sprite

func _ready():
	add_to_group("bullets")

func setup(pos, pointer, dir, owned):
	global_transform.origin = pos.global_transform.origin
	direction = dir
	velocity = direction * speed
	owned_by = owned
#	var angle = pos.global_transform.origin.angle_to(pointer.global_transform.origin)
#
#	var origin_2d = Vector2(pos.global_transform.origin.x, pos.global_transform.origin.y)
#	var pointer_2d = Vector2(pointer.global_transform.origin.x, pointer.global_transform.origin.y)
#	var angle = float(origin_2d.angle_to(pointer_2d))
#
#	angle *= 180/3.14159
#	print("angle is", angle)
#	$Sprite.rotation_degrees.y = angle
#	look_at(pointer,Vector3.UP)
#	look_at(pointer.global_transform.origin, Vector3.ZERO)
#	$Sprite.rotation_degrees.y = 57 * (pos.global_transform.origin.angle_to(pointer.global_transform.origin))
	if owned_by.is_in_group("allies"):
		print("pointer at ", pointer.global_transform.origin)
		print("origin at ", pos.global_transform.origin)
#	rotation.y = Vector2(p_pos.x, p_pos.y).angle()
	
func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		var hit = collision.get_collider()
		if hit.is_in_group("enemies") and owned_by.is_in_group("allies"):
			hit.die()
			get_tree().call_group("cameras","shake")
		queue_free()
