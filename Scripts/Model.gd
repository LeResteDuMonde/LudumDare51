extends Sprite

const RANGE_ENUMERATOR = 10

var texture_size = get_texture().get_width()
var model_size = texture_size / RANGE_ENUMERATOR
var hard_mode = true

func init_model(n):
	var pixels = []
	pixels.resize(n)
	for i in range(0,n):
		pixels[i] = []
		pixels[i].resize(n)
	return pixels

func reset_model(model):
	for x in range(0,model_size-1):
		for y in range(0,model_size-1):
			model[x][y] = 0

var opaque_pixel_count
var model = init_model(model_size)

func drawing_to_model(x):
	return int((x + RANGE_ENUMERATOR/2)/RANGE_ENUMERATOR)

func build_model():
	reset_model(model)
	opaque_pixel_count = 0
	for x in range(texture_size):
		for y in range(texture_size):
			if(is_pixel_opaque(Vector2(x, y) - Vector2(texture_size/2,texture_size/2))):
				if (model[drawing_to_model(x)][drawing_to_model(y)] == 0):
					opaque_pixel_count += 1
					model[drawing_to_model(x)][drawing_to_model(y)] = 1

# var point_scene = load("res://Scenes/ModelPoint.tscn")

# func add_point(i,j):
# 	var point = point_scene.instance()

# 	add_child(point)
# 	# points += [point]

# 	var pixel_position = Vector2(i,j) - Vector2(texture_size,texture_size)/2 #* get_texture().get_width()
# 	point.position = pixel_position

var debug_point_scene = load("res://Scenes/ModelDebug.tscn")
var in_texture = load("res://Sprites/Debug/in.png")
var out_texture = load("res://Sprites/Debug/out.png")
var miss_texture = load("res://Sprites/Debug/miss.png")

func add_debug(i,j,texture):
	var point = debug_point_scene.instance()

	add_child(point)
	# points += [point]

	var pixel_position = Vector2(i,j) - Vector2(texture_size,texture_size)/2 #* get_texture().get_width()
	point.position = pixel_position
	point.get_node("Sprite").texture = texture
	point.scale = Vector2(RANGE_ENUMERATOR*5, RANGE_ENUMERATOR*5)

onready var canvas_pos = get_node("..").position

func look_around(drawing, x, y):
	for i in range(-2,3):
		for j in range(-2,3):
			var x1 = min(max(x+i,0), model_size-1)
			var y1 = min(max(y+j,0), model_size-1)
			if drawing[x1][y1]:
				return true
	return false

func score(lines):
	# Compute drawing matrix
	var drawing = init_model(model_size)
	reset_model(drawing)
	for line in lines:
		var pc = line.get_point_count()
		for point in line.points:
			var pos = point - canvas_pos + Vector2(texture_size/2,texture_size/2)
			var x = int(min(max(drawing_to_model(pos.x), 0), model_size-1))
			var y = int(min(max(drawing_to_model(pos.y), 0), model_size-1))
			drawing[x][y] = 1

	var good_painted = 0
	var bad_painted = 0
	for x in range(0,model_size-1):
		for y in range(0,model_size-1):
			if model[x][y] and look_around(drawing,x,y):
				#add_debug(x*RANGE_ENUMERATOR,y*RANGE_ENUMERATOR, in_texture)
				good_painted+=1
			if drawing[x][y] and not look_around(model,x,y):
				#add_debug(x*RANGE_ENUMERATOR,y*RANGE_ENUMERATOR, out_texture)
				bad_painted+=1
			#if model[x][y] and not look_around(drawing,x,y):
				#add_debug(x*RANGE_ENUMERATOR,y*RANGE_ENUMERATOR, miss_texture)
			# 	pass

	var score = good_painted*100/opaque_pixel_count
	score -= bad_painted
	score = max(score,0)

	return score

func set_model(model):
	set_texture(model)
	build_model()

	if(hard_mode): hard_mode()

func hard_mode():
	pass
