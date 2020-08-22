class_name State
extends Spatial

export var state_name = "State"
onready var host = get_parent().get_parent()

func get_raw_input() -> Dictionary:
	var inputs = {
		is_moving = Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_backward") or Input.is_action_pressed("move_forward"),
		input_direction = get_input_direction()
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
