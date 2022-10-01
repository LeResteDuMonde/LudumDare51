extends Node2D

var rng : RandomNumberGenerator = RandomNumberGenerator.new()

var nb_customers = 3
onready var customers = []

var customer_scene = load("res://Scenes/Customer.tscn")

func _ready():
	create_customers()
	new_customer()

func _on_Timer_new_customer():
	get_node("../Canvas").score_and_reset()
	if(customers != []):
		new_customer()
	else:
		get_node("/root/MainScene").load_score()
		# TODO score scene
		pass

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
	#set_customer_position()

func new_customer():
	var customer = customers.pop_front()
	var drawing = customer.drawing
	get_node("../Canvas/Model").set_model(drawing)
	remove_child(customer)
	#for cust in customers:
	#	cust.position +=(Vector2(200, 0))
	set_customer_position()

func set_customer_position():
	for i in range(0, customers.size()):
		var tween := create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
		var new_position = Vector2.ZERO
		
		if(i < 3):
			new_position = Vector2(-i*200-300, 400)
			tween.tween_property(customers[i], "scale", Vector2(1,1) , 1)
		else:
			new_position = Vector2(-(i-3)*100-500, 200)
		
		
		tween.parallel().tween_property(customers[i], "position", new_position, 1)
		tween.parallel().tween_property(customers[i], "rotation", -.5 , .5)
		tween.tween_property(customers[i], "rotation", 0.01 , .3)

	yield(wait(1.3),"completed")
	
	for i in range(0, min(customers.size(),2)):
		customers[i].set_drawing_visible()

func wait(s):
	var t = Timer.new()
	t.set_wait_time(s)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
