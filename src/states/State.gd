class_name State
extends Spatial

export var is_bot = false
export var state_name = "State"
onready var host = get_parent().get_parent()

func get_raw_input() -> Dictionary:
	var inputs	
	if not is_bot:
		inputs = {
			is_moving = Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_backward") or Input.is_action_pressed("move_forward"),
			input_direction = get_input_direction(),
			is_jumping = Input.is_action_pressed("jump") and host.is_on_floor(),
			is_shooting = Input.is_action_pressed("shoot")
		}
	else:
		inputs = {
			is_moving = false,
			input_direction = Vector3.BACK,
			is_jumping = false,
			is_shooting = true
		}		
	return inputs
	
func interpret_inputs(input):
	return "idle"

func enter():
	pass

func exit():
	pass

func get_input_direction() -> Vector3:
	return Vector3(float(Input.is_action_pressed("move_right")) - float(Input.is_action_pressed("move_left")), 0, float(Input.is_action_pressed("move_backward")) - float(Input.is_action_pressed("move_forward")))

func run(input):
	pass
