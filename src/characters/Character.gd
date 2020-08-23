class_name Character
extends KinematicBody

var _state = null
var possible_states : Dictionary = {}
onready var states_holder = $States
onready var state_label = $HUD/StateLabel
onready var death_particle = preload("res://src/particles/DeathParticle.tscn")
onready var grave = preload("res://src/particles/Grave.tscn")
onready var object_holder = get_parent().get_parent().get_node("ObjectHolder")
onready var shot_cd_timer = $Timers/ShotCD

onready var spell_spawn_point = $Pivot/Staff/SpellSpawner
onready var spell_pointer = $Pivot/Staff/SpellPointer

# Called when the node enters the scene tree for the first time.
func _ready():
	if states_holder != null:
		for child in states_holder.get_children():
			possible_states[child.state_name] = child
			if _state == null:
				_state = child

func _physics_process(delta):
	var input = _state.get_raw_input()
	change_state(_state.interpret_inputs(input))
	_state.run(input)

func change_state(state_name, repeat = false):
	if state_label != null:
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
	
func die():
	var d = death_particle.instance()
	d.global_transform.origin = global_transform.origin + (Vector3.UP * 0.2)
	object_holder.add_child(d)
	d.emitting = true
	
	d = grave.instance()
	d.global_transform.origin = global_transform.origin + (Vector3.UP * 0.5)
	object_holder.add_child(d)
	queue_free()

func shoot(resource):
	var f = resource.instance()
	var dir = spell_spawn_point.global_transform.origin.direction_to(spell_pointer.global_transform.origin)
	f.setup(spell_spawn_point, spell_pointer, dir, self)
	object_holder.add_child(f)
	shot_cd_timer.start()
