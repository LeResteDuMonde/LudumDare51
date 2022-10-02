extends Node2D

onready var sceneManager = get_node("../")
onready var resultManager = sceneManager.get_node("ResultManager")

func _ready():
	resultManager.load_game()
	get_node("CanvasLayer/Highscores/Normal/Score").text = str(resultManager.highscore_normal) + "%"
	get_node("CanvasLayer/Highscores/Hard/Score").text = str(resultManager.highscore_hard) + "%"
	pass # Replace with function body.

func _on_Play_button_down():
	resultManager.hard_mode = false
	sceneManager.load_game()

func _on_PlayHard_button_down():
	resultManager.hard_mode = true
	sceneManager.load_game()

func _on_Quit_button_down():
	get_tree().quit()
