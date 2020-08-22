class_name Player
extends Character

var is_flipped : bool = false
var weapon_angle_limits = [-60, 60]
onready var tween
onready var sprite = $Sprite
onready var pivot = $Pivot
onready var camera = $Addons/Camera
onready var spell_spawn_point = $Pivot/Staff/SpellSpawner
onready var shot_cd_timer = $Timers/ShotCD

onready var bullet_holder = get_parent().get_parent().get_node("BulletHolder")
onready var fireball_resource = preload("res://src/spells/Fireball.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	change_direction("move_forward")

func change_direction(dir):
	sprite.play(dir)

func _physics_process(delta):
	point_staff_to_mouse()
	
func point_staff_to_mouse():
	var ray_length = 10000
	var mouse_pos = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	
	var space_state = get_world().get_direct_space_state()
	var result = space_state.intersect_ray(from, to)
	
	if result.size() > 0:
		var temp = result["position"]
		print(temp)
		pivot.look_at(Vector3(temp.x, temp.y, temp.z), Vector3.UP)
		pivot.rotation_degrees.x = 0
		if pivot.rotation_degrees.y < weapon_angle_limits[0]:
			pivot.rotation_degrees.y = weapon_angle_limits[0]
		elif pivot.rotation_degrees.y > weapon_angle_limits[1]:
			pivot.rotation_degrees.y = weapon_angle_limits[1]

func _input(event):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and shot_cd_timer.is_stopped():
#	if event.is_action_pressed("shoot") and shot_cd_timer.is_stopped():
		var f = fireball_resource.instance()
		f.setup(spell_spawn_point.global_transform.origin, Vector3.FORWARD)
		bullet_holder.add_child(f)
		shot_cd_timer.start()
