class_name Enemy
extends Character

var is_flipped : bool = false
var weapon_angle_limits = [-60, 60]
onready var tween
onready var sprite = $Sprite
onready var pivot = $Pivot

var _phase = "idle"

var PHASES = {
	IDLE = "idle",
	CHASE = "chase",
	ATTACK = "attack"
}

var target = null

var velocity : Vector3

onready var slash_resource = preload("res://src/spells/Slash.tscn")
# Called when the node enters the scene tree for the first time.

func _ready():
	add_to_group("enemies")
	change_direction("move_forward")
	randomize()
	shot_cd_timer.wait_time = 1.0 + ((randi() % 5)/10.0)

func change_direction(dir):
	sprite.play(dir)

func _physics_process(delta):
	velocity += Vector3.DOWN * 1
	velocity = move_and_slide(velocity, Vector3.UP)
	
	if target != null:
		if _state.get_raw_input().is_shooting and shot_cd_timer.is_stopped():
			if (global_transform.origin.distance_to(target.global_transform.origin)) < 50:
				shoot(slash_resource)
		#TODO add face enemy

func set_target(t):
	target = t
