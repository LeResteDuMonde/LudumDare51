extends Node2D

onready var sceneManager = get_node("../")
onready var resultManager = sceneManager.get_node("ResultManager")

func _ready():
	resultManager.load_game()
	get_node("CanvasLayer/Highscores/Normal/Score").text = str(resultManager.highscore_normal) + "%"
	get_node("CanvasLayer/Highscores/Hard/Score").text = str(resultManager.highscore_hard) + "%"
	pass # Replace with function body.

func _on_Play_button_down():
	sceneManager.load_game()
