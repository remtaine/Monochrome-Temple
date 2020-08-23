class_name Screenshaker
extends Spatial

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

onready var camera = get_parent()
onready var tween = $Tween
onready var frequency = $FrequencyTimer
onready var duration = $DurationTimer

var amplitude = 0
var priority = 0

func start(priority = 0, d = 0.5, f = 60, amplitude = 0.6):
	if self.priority <= priority:
		self.priority = priority 
		self.amplitude = amplitude + priority * 3 
		frequency.set_wait_time(1.0/float(f * (1 + float(priority)/10.0)))
		duration.set_wait_time(d)
		
		duration.start()
		frequency.start()
		
		_new_shake()
	
func _new_shake():
	var rand = Vector2()
	randomize()
	rand.x =  rand_range(-amplitude, amplitude)
	rand.y =  rand_range(-amplitude, amplitude)
	change_offset(rand)

func reset():
	change_offset(Vector2.ZERO)
	priority = 0

func change_offset(val):
	tween.interpolate_property(camera, "h_offset", camera.h_offset, val.x, frequency.wait_time, TRANS, EASE)
	tween.interpolate_property(camera, "v_offset", camera.v_offset, val.y, frequency.wait_time, TRANS, EASE)
	tween.start()
	
func _on_FrequencyTimer_timeout():
	_new_shake()

func _on_DurationTimer_timeout():
	reset()
	frequency.stop()
