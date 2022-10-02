extends Node2D

onready var sceneManager = get_node("../")

func _ready():
	pass # Replace with function body.

func _on_Menu_pressed():
	sceneManager.load_menu()
