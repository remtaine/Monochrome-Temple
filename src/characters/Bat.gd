class_name Bat
extends Character

var is_flipped : bool = false
var weapon_angle_limits = [-60, 60]
onready var tween = $Addons/Tween
onready var sprite = $Sprite
onready var pivot = $Pivot

var dist = 3.0
var duration = 1.5
var _phase = "idle"
var target = null

var velocity : Vector3
var going_down = true

onready var slash_resource = preload("res://src/spells/Slash.tscn")
# Called when the node enters the scene tree for the first time.

func _ready():
	add_to_group("enemies")
	change_direction("move_forward")
	tween.interpolate_property(self,"translation", self.translation, self.translation + (Vector3.DOWN* dist), duration,Tween.TRANS_LINEAR,Tween.EASE_IN)
	tween.start()
		
func change_direction(dir):
	sprite.play(dir)

func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector3.UP)
	
	if target != null:
		look_at(target.global_transform.origin, Vector3.UP)
		if _state.get_raw_input().is_shooting and shot_cd_timer.is_stopped():
			if (global_transform.origin.distance_to(target.global_transform.origin)) < 50:
				shoot(slash_resource)
		#TODO add face enemy

func set_target(t):
	target = t

func _on_Tween_tween_all_completed():
	if going_down:
		going_down = false
		tween.interpolate_property(self,"translation", self.translation, self.translation + (Vector3.UP * dist), duration,Tween.TRANS_LINEAR,Tween.EASE_IN)
		tween.start()
	else:
		going_down = true
		tween.interpolate_property(self,"translation", self.translation, self.translation + (Vector3.DOWN * dist), duration,Tween.TRANS_LINEAR,Tween.EASE_IN)
		tween.start()		
