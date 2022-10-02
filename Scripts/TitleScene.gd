extends Node2D

onready var sceneManager = get_node("../")
onready var resultManager = sceneManager.get_node("ResultManager")
onready var stencilManager = sceneManager.get_node("ExternalStencilManager")

onready var loading_wheel = $CanvasLayer/LoadingWheel
func _ready():
	resultManager.load_game()

	set_highscores()
	#get_node("CanvasLayer/Highscores/Normal/Score").text = str(resultManager.highscore_normal) + "%"
	#get_node("CanvasLayer/Highscores/Hard/Score").text = str(resultManager.highscore_hard) + "%"
	set_external_stencil_count()
	
	if(OS.has_feature("HTML5")):
		$CanvasLayer/Quit.hide()
		$CanvasLayer/Buttons/LoadExternalStencils.disabled = true

func _on_Play_button_down():
	resultManager.hard_mode = false
	sceneManager.load_game()

func _on_PlayHard_button_down():
	resultManager.hard_mode = true
	sceneManager.load_game()

func _on_Quit_button_down():
	get_tree().quit()

func _on_LoadExternalStencil_pressed():
	loading_wheel.show()
	yield(get_tree().create_timer(0.02), "timeout")
	#stencilManager.load_external_stencils()
	yield(stencilManager.load_external_stencils(),"completed")
	set_external_stencil_count()
	loading_wheel.hide()

func set_external_stencil_count():
	var count_text = get_node("CanvasLayer/ExternalStencils/Count")
	var count = stencilManager.stencils.size()

	if(count > 0):
		count_text.show()
		count_text.text = str(count)

func set_highscores():
	var normal = resultManager.highscore_normal
	var hard = resultManager.highscore_hard

	var highscores = get_node("CanvasLayer/Highscore/Highscore")
	
	if(normal == 0 && hard == 0):
		highscores.hide()
	else:
		highscores.show()

	if(normal != 0):
		highscores.get_node("Normal").show()
		highscores.get_node("Normal/Score").text = str(normal) + "%"
	else:
		highscores.get_node("Normal").hide()

	if(hard != 0):
		highscores.get_node("Hard").show()
		highscores.get_node("Hard/Score").text = str(hard) + "%"
	else:
		highscores.get_node("Hard").hide()	
