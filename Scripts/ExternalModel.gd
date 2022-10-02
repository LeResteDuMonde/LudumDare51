extends Node

onready var model_sprite = $Sprite

func _ready():
    var dir = Directory.new()
    dir.open("user://")
    dir.make_dir("external_model")

func _on_LoadExternalModel_button_down():
	var new_model = get_external_texture("user://external_model/model.png")
	model_sprite.set_texture(new_model)

func get_external_texture(path):
	var img = Image.new()
	img.load(path)
	var texture = ImageTexture.new()
	texture.create_from_image(img)
	return texture