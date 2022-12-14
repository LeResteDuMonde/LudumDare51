extends Sprite

const MODEL_SCALE = 15

var texture_size = get_texture().get_width()
var stencil_size = texture_size / MODEL_SCALE

func init_stencil(n):
	print(n)
	var pixels = []
	pixels.resize(n)
	for i in range(0,n):
		pixels[i] = []
		pixels[i].resize(n)
	return pixels

func reset_stencil(stencil):
	for x in range(0,stencil_size-1):
		for y in range(0,stencil_size-1):
			stencil[x][y] = 0

var opaque_pixel_count
var stencil = init_stencil(stencil_size)

func drawing_to_stencil(x):
	return int((x + MODEL_SCALE/2)/MODEL_SCALE)

func stencil_to_drawing(x):
	return x*MODEL_SCALE

func build_stencil(mini):
	reset_stencil(stencil)

	var mini_image = mini.get_data()
	mini_image.lock()

	opaque_pixel_count = 1
	for x in range(stencil_size):
		for y in range(stencil_size):
			if(mini_image.get_pixel(x, y).a > 0.0):
				if (stencil[x][y] == 0):
					opaque_pixel_count += 1
				stencil[x][y] = 1

# var point_scene = load("res://Scenes/StencilPoint.tscn")

# func add_point(i,j):
# 	var point = point_scene.instance()

# 	add_child(point)
# 	# points += [point]

# 	var pixel_position = Vector2(i,j) - Vector2(texture_size,texture_size)/2 #* get_texture().get_width()
# 	point.position = pixel_position

var debug_point_scene = load("res://Scenes/StencilDebug.tscn")
var in_texture = load("res://Sprites/Debug/in.png")
var out_texture = load("res://Sprites/Debug/out.png")
var miss_texture = load("res://Sprites/Debug/miss.png")

var debug_points = []

func add_debug(i,j,texture):
	var point = debug_point_scene.instance()
	debug_points += [point]

	add_child(point)

	var pixel_position = Vector2(i,j) - Vector2(texture_size,texture_size)/2 #* get_texture().get_width()
	point.position = pixel_position
	point.get_node("Sprite").texture = texture
	point.scale = Vector2(MODEL_SCALE*5, MODEL_SCALE*5)

func clear_debug():
	for p in debug_points:
		remove_child(p)
	debug_points = []

onready var canvas_pos = get_node("..").position

func look_around(drawing, x, y):
	for i in range(-2,3):
		for j in range(-1,2):
			var x1 = min(max(x+i,0), stencil_size-1)
			var y1 = min(max(y+j,0), stencil_size-1)
			if drawing[x1][y1]:
				return true
	return false

func score(lines):
	clear_debug()

	# Compute drawing matrix
	var drawn_pixel_count = 0
	var drawing = init_stencil(stencil_size)
	reset_stencil(drawing)
	for line in lines:
		var pc = line.get_point_count()
		for point in line.points:
			var pos = point - canvas_pos + Vector2(texture_size/2,texture_size/2)
			var x = int(min(max(drawing_to_stencil(pos.x), 0), stencil_size-1))
			var y = int(min(max(drawing_to_stencil(pos.y), 0), stencil_size-1))
			if drawing[x][y]:
				drawn_pixel_count += 1
			drawing[x][y] = 1

	var good_painted = 0
	var bad_painted = 0
	for x in range(0,stencil_size-1):
		for y in range(0,stencil_size-1):
			if stencil[x][y] and look_around(drawing,x,y):
				# add_debug(stencil_to_drawing(x),stencil_to_drawing(y), in_texture)
				good_painted+=1
			# elif stencil[x][y]:
			# 	add_debug(stencil_to_drawing(x),stencil_to_drawing(y), miss_texture)
			if drawing[x][y] and not look_around(stencil,x,y):
				# add_debug(stencil_to_drawing(x),stencil_to_drawing(y), out_texture)
				bad_painted+=1

	print("opaque: " + str(opaque_pixel_count))
	print("good: " + str(good_painted))
	var good = good_painted*100/opaque_pixel_count
	var bad = bad_painted*100/max(drawn_pixel_count, 1)
	var score = max(good-bad,0)

	return score

onready var resultManager = get_node("/root/MainScene/ResultManager")

func set_stencil(drawing, mini):
	set_texture(drawing)
	build_stencil(mini)

	if(resultManager.hard_mode): hard_mode()

func hard_mode():
	modulate = Color(1,1,1,.5)

	var tween := create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "modulate",  Color(1,1,1,0) , 5.25)
