extends Node2D

onready var _lines := $Lines

var _pressed := false
var _inCanva := false

var _current_line: Line2D

func _input(event: InputEvent) -> void:
	if _inCanva && event is InputEventMouseButton:
		_pressed = event.pressed

		if _pressed:
			_current_line = Line2D.new()
			_current_line.default_color = Color.black
			_current_line.texture = load("res://Sprites/Canva.png")
			_current_line.width = 10
			_current_line.begin_cap_mode = 2
			_current_line.end_cap_mode = 2
			_current_line.set_light_mask(1)
			_lines.add_child(_current_line)
			_current_line.set_global_position(Vector2.ZERO)

	if event is InputEventMouseMotion && _pressed:
		_current_line.add_point(get_global_mouse_position())

func _on_Area2D_mouse_exited():
	_pressed = false
	_inCanva = false

func _on_Area2D_mouse_entered():
	_inCanva = true


func _on_Timer_new_customer():
	#print("new Customer")
	$Drawing._on_Timer_new_customer()
