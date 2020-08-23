class_name Idle
extends State

func _ready():
	state_name = "idle" # Replace with function body.

func enter():
	host.change_direction("move_forward")
	host.velocity = Vector3.ZERO
	
func interpret_inputs(input):
	if input.is_jumping:
		return "jumping"
	elif input.is_moving:
		return "moving"
	else:
		return state_name
