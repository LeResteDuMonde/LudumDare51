extends Node2D

var titleScene = preload("res://Scenes/TitleScene.tscn")
var gameScene = preload("res://Scenes/GameScene.tscn")
var resultScene = preload("res://Scenes/ResultScene.tscn")

var currentScene

func _ready():
	currentScene = titleScene.instance()
	add_child(currentScene)

func load_menu():
	remove_child(currentScene)
	currentScene = titleScene.instance()
	add_child(currentScene)
	get_node("ResultManager").reset()

func load_game(hard = false):
	remove_child(currentScene)
	currentScene = gameScene.instance()
	if(hard) : set_hard_mode()
	add_child(currentScene)
	get_node("ResultManager").reset()

func load_result():
	remove_child(currentScene)
	currentScene = resultScene.instance()
	add_child(currentScene)

func set_hard_mode():
	currentScene.get_node("Canvas/Model").set_hard_mode()