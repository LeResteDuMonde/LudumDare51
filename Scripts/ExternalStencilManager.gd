extends Node

func _ready():
    var dir = Directory.new()
    dir.open("user://")
    dir.make_dir("external_stencil")

var stencils = []
var stencils_mini = []

func texture_from_image(img):
	var texture = ImageTexture.new()
	texture.create_from_image(img)
	return texture

const MODEL_SCALE = 15
const IMG_SIZE = 1080

func scale_image(img):
	img.lock()
	var simg = Image.new()
	simg.create(IMG_SIZE/MODEL_SCALE, IMG_SIZE/MODEL_SCALE, 0, 5)
	simg.lock()
	for x in range(0, IMG_SIZE-1):
		for y in range(0, IMG_SIZE-1):
			if img.get_pixel(x, y).a > 0:
				simg.set_pixel(x/MODEL_SCALE, y/MODEL_SCALE, Color(0,0,0,1))
	return simg

func load_external_stencils():
	var dir_name = "user://external_stencil"
	var dir = Directory.new()
	if dir.open(dir_name) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".png"):
				var img = Image.new()
				img.load(dir_name + "/" + file_name)
				if img.get_height() == IMG_SIZE and img.get_width() == IMG_SIZE:
					stencils += [texture_from_image(img)]
					stencils_mini += [texture_from_image(scale_image(img))]
					print(file_name + " loaded")
			file_name = dir.get_next()
