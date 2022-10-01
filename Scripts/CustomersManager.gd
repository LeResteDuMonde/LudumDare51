extends Node2D

var rng : RandomNumberGenerator = RandomNumberGenerator.new()

var nb_customers = 3
onready var customers = []

var customer_scene = load("res://Scenes/Customer.tscn")

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
		var customer = customer_scene.instance()
		customer.set_position(Vector2(-i*200-300, 400))
		customer.set_drawing(load(drawings.pop_at(n)))
		add_child(customer)
		customers += [customer]

func new_customer():
	if(customers != []):
		var customer = customers.pop_front()
		var drawing = customer.drawing
		get_node("../Canva/Model").set_model(drawing)
		remove_child(customer)
		for cust in customers:
			cust.position +=(Vector2(200, 0))
