extends Node

const DRAWING_TIME = 10

var paused = true
var timer
var timer_seconds
var sound_id = 0;

signal new_customer()

onready var label := $Label

onready var timer_sound = [$Audio1,$Audio2]

func _ready():
	reset_timer()
	paused = false

func _process(delta):
	if(!paused):
		process_timer(delta)	

func process_timer(delta):

	if(timer_seconds < 0):
		second_passed()
	if(timer < 3):
		label.add_color_override("font_color", Color.red)
	if timer <= 0:
		end_timer()

	label.text = str(timer).substr(0,3)
	timer -= delta
	timer_seconds -= delta

func end_timer():
	reset_timer()
	emit_signal("new_customer")

func reset_timer():
	sound_id = 0
	label.add_color_override("font_color", Color.black)
	timer = DRAWING_TIME
	timer_seconds = 1

func second_passed():
	var new_time = 1
	if(timer < 3): 
		new_time = 0.25
	elif(timer < 6): 
		new_time = 0.5
	sound_id = 0 if (sound_id == 1) else 1
	timer_seconds = new_time
	timer_sound[sound_id].play()

