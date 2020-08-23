class_name Player
extends Character

var is_flipped : bool = false
var weapon_angle_limits = [-60, 60]
onready var tween
onready var sprite = $Sprite
onready var pivot = $Pivot
onready var camera = $CameraBase/Camera

const GRAVITY = 0.7
const MOUSE_SENS = 0.3

var velocity : Vector3
onready var fireball_resource = preload("res://src/spells/Fireball.tscn")
onready var hp_bar = $HUD/HPBar

# Called when the node enters the scene tree for the first time.

func _ready():
#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	add_to_group("allies")
	change_direction("move_forward")
	hp_bar.max_value = hp
	hp_bar.value = hp
#	while not is_on_floor():
#		move_and_slide(Vector3.DOWN * 10, Vector3.UP)
#		print("floor", is_on_floor())
#		print("ceiling", is_on_ceiling())
#		print("wall", is_on_wall())

func change_direction(dir):
	sprite.play(dir)

func _physics_process(delta):
	point_staff_to_mouse()
	velocity += Vector3.DOWN * GRAVITY
	velocity = move_and_slide(velocity, Vector3.UP)
	print(global_transform.origin.y)
func _input(event):
	if is_dead:
		return
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and shot_cd_timer.is_stopped():
#	if event.is_action_pressed("shoot") and shot_cd_timer.is_stopped():
		shoot(fireball_resource)
	if Input.is_mouse_button_pressed(BUTTON_RIGHT):# and shot_cd_timer.is_stopped():
#	if event.is_action_pressed("shoot") and shot_cd_timer.is_stopped():
		if event is InputEventMouseMotion:
	#			camera.look_at(Vector3(event.position.x, 0, event.position.y), Vector3.UP)
			camera_base.rotation_degrees.y -= MOUSE_SENS * event.relative.x
			camera_base.rotation_degrees.x -= MOUSE_SENS * event.relative.y
			camera_base.rotation_degrees.x = clamp(camera_base.rotation_degrees.x, -30, 30)

func damage(dmg = 1):
	.damage(dmg)
	hp_bar.value = hp
	
func point_staff_to_mouse():
	pass
	var ray_length = 10000
	var mouse_pos = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length

	var space_state = get_world().get_direct_space_state()
	var result = space_state.intersect_ray(from, to)

	if result.size() > 0:
		var temp = result["position"]
		pivot.look_at(Vector3(temp.x, temp.y, temp.z), Vector3.UP)
		if global_transform.origin.y < 3.2: # if on floor
			pivot.rotation_degrees.x =  max(0, pivot.rotation_degrees.x)
		
#		if is_on_floor():
#			pivot.rotation_degrees.x = 0
#		else:
#			pivot.rotation_degrees.x = -30
#		if pivot.rotation_degrees.y < weapon_angle_limits[0]:
#			pivot.rotation_degrees.y = weapon_angle_limits[0]
#		elif pivot.rotation_degrees.y > weapon_angle_limits[1]:
#			pivot.rotation_degrees.y = weapon_angle_limits[1]

func die():
	is_dead = true
	var d = death_particle.instance()
	d.global_transform.origin = global_transform.origin + (Vector3.UP * 0.2)
	object_holder.add_child(d)
	d.emitting = true
	
	d = grave.instance()
	d.global_transform.origin = global_transform.origin + (Vector3.UP * 0.5)
	object_holder.add_child(d)
	visible = false
	get_tree().call_group("levels", "show_death_menu")
	set_physics_process(false)
