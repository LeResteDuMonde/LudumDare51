extends Sprite

#var points
const RANGE_ENUMERATOR = 10

func _ready():
	analyse_drawing()

func analyse_drawing():
	#var pixel_count = 0
	#var opaque_pixel_count = 0
	var size = get_texture().get_width()
	for i in range(size):
		for j in range(size):
			if(i%RANGE_ENUMERATOR == 0 && j % RANGE_ENUMERATOR == 0):
				if(is_pixel_opaque(Vector2(i,j) - Vector2(size,size)/2)):
					add_point(i,j)
					#opaque_pixel_count += 1
				#pixel_count+=1
	#print("opaque pixel in " + str(pixel_count) + " pixels : " + str(opaque_pixel_count))


func add_point(i,j):
	var size = get_texture().get_width()
	var point_scene = load("res://Scenes/DrawingPoint.tscn")
	var point = point_scene.instance()
	
	add_child(point)
	#points.add_item(point)

	var pixel_position = Vector2(i,j) - Vector2(size,size)/2 #* get_texture().get_width()
	#print(pixel_position)
	point.position = pixel_position

func _on_Timer_new_customer():
	#print("calculate_accuracy")
	calculate_accuracy()

func calculate_accuracy():
	var points_filled = 0
	for point in self.get_children():
		if point.is_filled():
			points_filled += 1
	print("points filled :" + str(points_filled))

	#TODO calculate accuracy with a formula combining points filled and points in drawn line

