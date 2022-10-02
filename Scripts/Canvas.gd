extends Node2D

onready var _lines := $Lines
onready var voice_line_player := $VoiceLine
var _pressed := false
var _inCanva := false

var current_drawing = []
var _current_line: Line2D

var rng : RandomNumberGenerator = RandomNumberGenerator.new()

onready var machine_sound := $TattooMachine
var line_texture = load("res://Sprites/Canva.png")

func _input(event: InputEvent) -> void:
	if _inCanva && event is InputEventMouseButton:
		_pressed = event.pressed

		if _pressed:
			_current_line = Line2D.new()
			_current_line.default_color = Color.black
			_current_line.texture = line_texture
			_current_line.width = 10
			_current_line.begin_cap_mode = 2
			_current_line.end_cap_mode = 2
			_current_line.set_light_mask(1)
			_lines.add_child(_current_line)
			_current_line.set_global_position($Lines.position)

			# Save it
			current_drawing += [_current_line]

			if !machine_sound.playing:
				machine_sound.play(rand_range(0,machine_sound.stream.get_length()))
		else:
			machine_sound.stop()

	if event is InputEventMouseMotion && _pressed:
		_current_line.add_point(get_global_mouse_position())

func clear_lines():
	machine_sound.stop()
	for l in current_drawing:
		_lines.remove_child(l)
	current_drawing = []

func _on_Area2D_mouse_exited():
	_pressed = false
	_inCanva = false
	machine_sound.stop()
	set_cursor(load("res://Sprites/Cursor/Cursor.png")) 

func _on_Area2D_mouse_entered():
	_inCanva = true
	set_cursor(load("res://Sprites/Cursor/Cursor2.png")) #TODO Pen cursor

func score_and_reset():
	var score = $Stencil.score(current_drawing)
	score_sound_effect(score)
	get_node("../CanvasLayer/Score/Label").text = str(score) + "%"
	get_node("/root/MainScene/ResultManager").add_tattoo(current_drawing, score)
	clear_lines()

func set_cursor(cursor_sprite):
	Input.set_custom_mouse_cursor(cursor_sprite)


func score_sound_effect(score):
	var score_label = "Insane"
	if (score < 20):
		score_label = "Ha"
	elif (score < 30):
		score_label = "Hmmm"
	elif (score < 40):
		score_label = "Well"
	elif (score < 50):
		score_label = "Ok"
	elif (score < 60):
		score_label = "ThankYou"
	elif (score < 70):
		score_label = "Nice"
	elif (score < 80):
		score_label = "Cool"
	elif (score < 90):
		score_label = "Great"

	var voice_lines = []
	var dir_name = "res://Audio/SoundEffect/VoiceLines/" + score_label
	var dir = Directory.new()
	if dir.open(dir_name) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with("mp3.import"):
				voice_lines += [(dir_name + "/" + file_name.replace(".import", ""))]
			file_name = dir.get_next()
	else:
		print("unable to load voice line")
	
	rng.randomize()
	#print(voice_lines.size())
	var voice_line = voice_lines[rng.randi_range(0,voice_lines.size()-1)]
	
	voice_line_player.set_stream(load(voice_line))
	voice_line_player.play()

