extends Node2D

var drawing

func _ready():
	pass # Replace with function body.

func set_drawing(texture):
	drawing = texture
	$WantedDrawing/Drawing.set_texture(texture)

func set_drawing_visible():
	$WantedDrawing/Drawing.show()
	$WantedDrawing/Bubble.show()
