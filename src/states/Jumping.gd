class_name Jumping
extends State

export var jump_height : int = 20
var last_direction : Vector3 = Vector3.ZERO
var direction : Vector3 = Vector3.ZERO

onready var tween = $Tween

func _ready():
	state_name = "jumping"

func enter():
	host.velocity += Vector3.UP * jump_height

func run(input):
	pass

func interpret_inputs(input):
	if not host.is_on_floor():
		return state_name
	elif input.is_moving:
		return "moving"
	else:
		return "idle"
