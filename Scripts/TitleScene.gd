extends Node2D

onready var sceneManager = get_node("../")
onready var resultManager = sceneManager.get_node("ResultManager")
onready var stencilManager = sceneManager.get_node("ExternalStencilManager")

func _ready():
	resultManager.load_game()
	get_node("CanvasLayer/Highscores/Normal/Score").text = str(resultManager.highscore_normal) + "%"
	get_node("CanvasLayer/Highscores/Hard/Score").text = str(resultManager.highscore_hard) + "%"
	set_external_stencil_count()

	if(OS.has_feature("HTML5")):
		$CanvasLayer/CanvasLayer/Quit.hide()
		$CanvasLayer/CanvasLayer/LoadExternalModel.disabled = true

func _on_Play_button_down():
	resultManager.hard_mode = false
	sceneManager.load_game()

func _on_PlayHard_button_down():
	resultManager.hard_mode = true
	sceneManager.load_game()

func _on_Quit_button_down():
	get_tree().quit()

func _on_LoadExternalStencil_pressed():
	stencilManager.load_external_stencils()
	set_external_stencil_count()

func set_external_stencil_count():
	get_node("CanvasLayer/ExternalStencils/Label").text = str(stencilManager.stencils.size()) + " external stencils"
