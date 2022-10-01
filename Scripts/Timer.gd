extends Node

const DRAWING_TIME = 10

var paused = true
var timer
var timer_seconds

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
	label.add_color_override("font_color", Color.black)
	timer = DRAWING_TIME
	timer_seconds = 1

func second_passed():
	timer_seconds = 1
	timer_sound[0].play()

