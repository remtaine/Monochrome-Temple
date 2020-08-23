class_name Enemy
extends Character

var is_flipped : bool = false
var weapon_angle_limits = [-60, 60]
onready var tween
onready var sprite = $Sprite
onready var pivot = $Pivot
onready var camera = $Addons/Camera

var velocity : Vector3

onready var slash_resource = preload("res://src/spells/Slash.tscn")
# Called when the node enters the scene tree for the first time.

func _ready():
	add_to_group("enemies")
	change_direction("move_forward")

func change_direction(dir):
	sprite.play(dir)

func _physics_process(delta):
	velocity += Vector3.DOWN * 1
	velocity = move_and_slide(velocity, Vector3.UP)
	
	if _state.get_raw_input().is_shooting and shot_cd_timer.is_stopped():
		shoot(slash_resource)
