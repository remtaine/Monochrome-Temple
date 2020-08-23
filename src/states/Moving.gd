class_name Moving
extends State

export var speed : int = 16
var last_direction : Vector3 = Vector3.ZERO
var direction : Vector3 = Vector3.ZERO

onready var tween = $Tween

func _ready():
	state_name = "moving" # Replace with function body.
	
func enter():
	pass

func run(input):
	direction = input.input_direction.normalized()
	host.velocity.x = direction.x * speed
	host.velocity.z = direction.z * speed
#	host.velocity += Vector3.DOWN * 10
	
#	host.move_and_slide(velocity)
	if host.velocity.x < 0:
		host.is_flipped = false
#		host.change_direction("move_left")
#		host.change_direction("move_forward")
	elif host.velocity.x > 0:
		host.is_flipped = false
#		host.change_direction("move_right")
#		host.change_direction("move_forward")
	if host.velocity.z > 0:
		host.change_direction("move_backward")
	else:
		host.change_direction("move_forward")
	
#	tween.interpolate_property(global_transform,"origin", host.global_transform.origin, host.position + velocity, 0.2, Tween.TRANS_LINEAR,Tween.EASE_IN)
#	tween.start()
#	host.position += velocity
#	host.velocity = host.move_and_slide(host.velocity, Vector3.UP)
	if not is_bot:
		host.velocity = host.velocity.rotated(Vector3.UP, host.camera_base.rotation.y)

func interpret_inputs(input):
	if input.is_jumping:
		return "jumping"
	elif input.is_moving:
		return state_name
	else:
		return "idle"
