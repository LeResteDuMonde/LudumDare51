extends Node2D

var drawing
var mini_drawing

var rng : RandomNumberGenerator = RandomNumberGenerator.new()
#onready var drawing_node = $WantedDrawing/Drawing

func _ready():
	set_customer_sprite()

func set_drawing(texture):
	drawing = texture
	$WantedDrawing/Drawing.set_texture(texture)

func set_mini_drawing(texture):
	mini_drawing = texture

func set_drawing_visible():
	$WantedDrawing/Drawing.show()
	#$WantedDrawing/Drawing.set_light_mask(1)
	$WantedDrawing/Bubble.show()

func set_customer_sprite():
	var sprites = []
	var dir_name = "res://Sprites/Customers"
	var dir = Directory.new()
	if dir.open(dir_name) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".png.import"):
				sprites += [(dir_name + "/" + file_name.replace(".import", ""))]
			file_name = dir.get_next()
	else:
		print("unable to load drawings")
	
	rng.randomize()
	var sprite_path = sprites[rng.randi_range(0,sprites.size()-1)]
	var sprite = load(sprite_path)
	$Sprite.set_texture(sprite)

	

