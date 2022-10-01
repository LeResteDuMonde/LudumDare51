extends Node

const DRAWING_TIME = 10

var paused = true
var timer
signal new_customer()

onready var label := $Label

func _ready():
	reset_timer()
	paused = false

func _process(delta):
	if(!paused):
		process_timer(delta)	

func process_timer(delta):

	if timer <= 0:
		end_timer()

	label.text = str(timer).substr(0,3)
	timer -= delta

func end_timer():
	reset_timer()
	emit_signal("new_customer")

func reset_timer():
	timer = DRAWING_TIME

