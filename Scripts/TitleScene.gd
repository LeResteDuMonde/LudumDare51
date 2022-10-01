extends Node2D

onready var sceneManager = get_node("../")

func _ready():
	pass # Replace with function body.

func _on_Play_button_down():
	sceneManager.load_game()
