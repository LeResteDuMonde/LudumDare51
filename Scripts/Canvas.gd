extends Node2D

onready var _lines := $Lines

var _pressed := false
var _inCanva := false

var current_drawing = []
var _current_line: Line2D

onready var sound_effect := $AudioStreamPlayer2D
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

			if !sound_effect.playing:
				sound_effect.play(rand_range(0,sound_effect.stream.get_length()))
		else:
			sound_effect.stop()

	if event is InputEventMouseMotion && _pressed:
		_current_line.add_point(get_global_mouse_position())

func clear_lines():
	sound_effect.stop()
	for l in current_drawing:
		_lines.remove_child(l)
	current_drawing = []

func _on_Area2D_mouse_exited():
	_pressed = false
	_inCanva = false
	sound_effect.stop()
	set_cursor(load("res://Sprites/Cursor/Cursor.png")) 

func _on_Area2D_mouse_entered():
	_inCanva = true
	set_cursor(null) #TODO Pen cursor

func score_and_reset():
	var score = $Model.score(current_drawing)
	get_node("../CanvasLayer/Score/Label").text = str(score) + "%"
	get_node("/root/MainScene/ResultManager").add_tattoo(current_drawing, score)
	clear_lines()

func set_cursor(cursor_sprite):
	Input.set_custom_mouse_cursor(cursor_sprite)
