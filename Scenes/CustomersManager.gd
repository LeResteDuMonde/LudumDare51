extends Node2D

var rng : RandomNumberGenerator = RandomNumberGenerator.new()

var customers
onready var drawings

func _ready():
	get_drawings()


func _on_Timer_new_customer():
	#set_drawing()
	pass

func get_drawings():
	#print("getting drawings")
	var dir = Directory.new()
	if dir.open("res://Sprites/Drawings") == OK:
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
				file_name = dir.get_next()
		print("directory finished")
	else:
		print("unable to load drawings")

func set_drawing():
	rng.randomize()
	var new_drawing = drawings[rng.randi_range(0,drawings.count)]

	var drawing = $Canva/Drawing

	drawing.sprite = new_drawing

