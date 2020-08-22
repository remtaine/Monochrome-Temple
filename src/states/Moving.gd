class_name Moving
extends State

export var speed : int = 16
var last_direction : Vector3 = Vector3.ZERO
var direction : Vector3 = Vector3.ZERO
var velocity : Vector3 = Vector3.ZERO

onready var host = get_parent().get_parent()
onready var tween = $Tween

func enter():
	pass

func run(input):
	direction = input.input_direction.normalized()
	velocity = direction * speed
#	host.move_and_slide(velocity)
	if velocity.x < 0:
		host.is_flipped = false
		host.change_direction("move_left")
		
	elif velocity.x > 0:
		host.is_flipped = false
		host.change_direction("move_right")
	elif velocity.z < 0:
		host.change_direction("move_forward")
	else:
		host.change_direction("move_backward")
			
#	tween.interpolate_property(global_transform,"origin", host.global_transform.origin, host.position + velocity, 0.2, Tween.TRANS_LINEAR,Tween.EASE_IN)
#	tween.start()
#	host.position += velocity
	host.move_and_slide(velocity, Vector3.UP)
	
func interpret_inputs(input):
	if input.is_moving:
		return state_name
	else:
		return "idle"
