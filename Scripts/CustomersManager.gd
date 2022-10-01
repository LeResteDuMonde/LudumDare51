extends Node2D

var rng : RandomNumberGenerator = RandomNumberGenerator.new()

var nb_customers = 3
onready var customers = []

func _ready():
	create_customers()
	new_customer()

func _on_Timer_new_customer():
	new_customer()
	# pass

func create_customers():
	var drawings = []
	var dir_name = "res://Sprites/Drawings"
	var dir = Directory.new()
	if dir.open(dir_name) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".png"):
				print(file_name)
				drawings += [(dir_name + "/" + file_name)]
			file_name = dir.get_next()
	else:
		print("unable to load drawings")

	# Now select the drawings
	rng.randomize()
	for i in range(0, nb_customers):
		var n = rng.randi_range(0,drawings.size()-1)
		customers += [load(drawings.pop_at(n))]

func new_customer():
	if(customers != []):
		var new_drawing = customers.pop_front()
		get_node("../Canva/Drawing").set_drawing(new_drawing)
