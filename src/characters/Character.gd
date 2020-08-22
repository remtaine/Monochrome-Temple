class_name Character
extends KinematicBody

var _state = null
var possible_states : Dictionary = {}
onready var states_holder = $States
onready var state_label = $Addons/StateLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	if states_holder != null:
		for child in states_holder.get_children():
			possible_states[child.state_name] = child
			if _state == null:
				_state = child
	print(_state.state_name)

func _physics_process(delta):
	var input = _state.get_raw_input()
	change_state(_state.interpret_inputs(input))
	_state.run(input)

func change_state(state_name, repeat = false):
	state_label.text = _state.state_name
	var new_state = possible_states[state_name]
	if _state != new_state or repeat:
		exit_state()
		_state = new_state
		enter_state()
	
func enter_state():
	_state.enter()
	
func exit_state():
	_state.exit()

func change_direction(dir):
	pass
