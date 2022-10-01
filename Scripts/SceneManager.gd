extends Node2D

var titleScene = preload("res://Scenes/TitleScene.tscn")
var gameScene = preload("res://Scenes/GameScene.tscn")
var resultScene = preload("res://Scenes/ResultScene.tscn")

var currentScene

onready var page_sound = $PageFlip

func _ready():
	currentScene = titleScene.instance()
	add_child(currentScene)

func load_menu():
	page_sound.play()
	remove_child(currentScene)
	currentScene = titleScene.instance()
	add_child(currentScene)
	get_node("ResultManager").reset()

func load_game():
	page_sound.play()
	remove_child(currentScene)
	currentScene = gameScene.instance()
	add_child(currentScene)
	get_node("ResultManager").reset()

func load_result():
	page_sound.play()
	remove_child(currentScene)
	currentScene = resultScene.instance()
	add_child(currentScene)
