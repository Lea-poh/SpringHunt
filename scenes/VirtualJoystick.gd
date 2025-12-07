extends Control

@export var max_distance := 60.0

@onready var base = $Base
@onready var knob = $Knob

var joystick_vector := Vector2.ZERO
var touching := false

func _ready():
	# ✅ Only show joystick on mobile
	if not OS.has_feature("mobile"):
		hide()
	else:
		show()	
	reset_knob()


func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			if base.get_global_rect().has_point(event.position):
				touching = true
				move_knob(event.position)
		else:
			touching = false
			reset_knob()

	if event is InputEventScreenDrag and touching:
		move_knob(event.position)

func move_knob(pos):
	var center = base.global_position + base.size / 2
	var dir = pos - center
	dir = dir.limit_length(max_distance)

	knob.global_position = center + dir - knob.size / 2
	joystick_vector = dir / max_distance

func reset_knob():
	knob.position = (base.size - knob.size) / 2
	joystick_vector = Vector2.ZERO
