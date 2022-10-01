extends Sprite

const RANGE_ENUMERATOR = 30

var texture_size = get_texture().get_width()
var model_size = texture_size / RANGE_ENUMERATOR

func init_model(n):
	var pixels = []
	pixels.resize(n)
	for i in range(0,n-1):
		pixels[i] = []
		pixels[i].resize(n)
	return pixels

func reset_model(model):
	for x in range(0,model_size-1):
		for y in range(0,model_size-1):
			model[x][y] = 0

var opaque_pixel_count
var model = init_model(model_size)

func build_model():
	reset_model(model)
	opaque_pixel_count = 0
	for x in range(texture_size):
		for y in range(texture_size):
			if(is_pixel_opaque(Vector2(x, y) - Vector2(texture_size/2,texture_size/2))):
				if (model[x/RANGE_ENUMERATOR][y/RANGE_ENUMERATOR] == 0):
					opaque_pixel_count += 1
					model[x/RANGE_ENUMERATOR][y/RANGE_ENUMERATOR] = 1
				# pixel_count+=1
	print("opaque pixel " + str(opaque_pixel_count))

# var point_scene = load("res://Scenes/ModelPoint.tscn")

# func add_point(i,j):
# 	var point = point_scene.instance()

# 	add_child(point)
# 	# points += [point]

# 	var pixel_position = Vector2(i,j) - Vector2(texture_size,texture_size)/2 #* get_texture().get_width()
# 	#print(pixel_position)
# 	point.position = pixel_position

onready var canvas_pos = get_node("..").position

func score(lines):
	# Compute drawing matrix
	var drawing = init_model(model_size)
	reset_model(drawing)
	for line in lines:
		var pc = line.get_point_count()
		for point in line.points:
			var pos = point - canvas_pos + Vector2(texture_size/2,texture_size/2)
			var x = min(max(pos.x/RANGE_ENUMERATOR, 0), model_size-1)
			var y = min(max(pos.y/RANGE_ENUMERATOR, 0), model_size-1)
			# print(Vector2(x,y))
			drawing[x][y] = 1

	var good_painted = 0
	var bad_painted = 0
	for x in range(0,model_size-1):
		for y in range(0,model_size-1):
			if model[x][y]:
				if drawing[x][y]:
					# add_point(x*RANGE_ENUMERATOR,y*RANGE_ENUMERATOR)
					good_painted+=1
			elif drawing[x][y]:
				bad_painted+=1
				pass

	var score = good_painted*100/opaque_pixel_count
	score -= bad_painted/10
	score = max(score,0)
	print(score)

	return score

func set_model(model):
	set_texture(model)
	build_model()
