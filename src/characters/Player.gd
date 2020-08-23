class_name Player
extends Character

var is_flipped : bool = false
var weapon_angle_limits = [-60, 60]
onready var tween
onready var sprite = $Sprite
onready var pivot = $Pivot
onready var camera = $Addons/Camera

var velocity : Vector3
onready var fireball_resource = preload("res://src/spells/Fireball.tscn")
# Called when the node enters the scene tree for the first time.

func _ready():
	add_to_group("allies")
	change_direction("move_forward")
#	while not is_on_floor():
#		move_and_slide(Vector3.DOWN * 10, Vector3.UP)
#		print("floor", is_on_floor())
#		print("ceiling", is_on_ceiling())
#		print("wall", is_on_wall())

func change_direction(dir):
	sprite.play(dir)

func _physics_process(delta):
	point_staff_to_mouse()
	velocity += Vector3.DOWN * 1
	velocity = move_and_slide(velocity, Vector3.UP)

func _input(event):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and shot_cd_timer.is_stopped():
#	if event.is_action_pressed("shoot") and shot_cd_timer.is_stopped():
		shoot(fireball_resource)

func point_staff_to_mouse():
	var ray_length = 10000
	var mouse_pos = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	
	var space_state = get_world().get_direct_space_state()
	var result = space_state.intersect_ray(from, to)
	
	if result.size() > 0:
		var temp = result["position"]
		pivot.look_at(Vector3(temp.x, temp.y, temp.z), Vector3.UP)
		pivot.rotation_degrees.x = 0
		
#		if is_on_floor():
#			pivot.rotation_degrees.x = 0
#		else:
#			pivot.rotation_degrees.x = -30			
		if pivot.rotation_degrees.y < weapon_angle_limits[0]:
			pivot.rotation_degrees.y = weapon_angle_limits[0]
		elif pivot.rotation_degrees.y > weapon_angle_limits[1]:
			pivot.rotation_degrees.y = weapon_angle_limits[1]
