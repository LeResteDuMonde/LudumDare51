extends Node2D

var gameScene = load("res://Scenes/GameScene.tscn")
var scoreScene = load("res://Scenes/ScoreScene.tscn")

var currentScene

func _ready():
	currentScene = gameScene.instance()
	add_child(currentScene)

func load_game():
	remove_child(currentScene)
	currentScene = gameScene.instance()
	add_child(currentScene)
	get_node("ResultManager").reset()

func load_score():
	remove_child(currentScene)
	currentScene = scoreScene.instance()
	add_child(currentScene)
