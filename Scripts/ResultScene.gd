extends Node2D

onready var sceneManager = get_node("../")
onready var resultManager = get_node("../ResultManager")

var tattooFrame = preload("res://Scenes/TattooFrame.tscn")

var positions = [
	Vector2(-650,-400),
	Vector2(-250,-400),
	Vector2(250,-400),
	Vector2(650,-400),
	Vector2(-650,-100),
	Vector2(-250,-100),
	Vector2(250,-100),
	Vector2(650,-100),
	Vector2(-650,200),
	Vector2(-250,200),
	Vector2(250,200),
	Vector2(650,200),
]

func add_frame(pos, tattoo, score):
	var frame = tattooFrame.instance()
	frame.position = pos

	var lines = frame.get_node("Lines")
	for l in tattoo:
		lines.add_child(l)

	frame.get_node("Label").text = str(score) + "%"
	add_child(frame)

func _ready():
	var tattoos = resultManager.tattoos
	var scores = resultManager.scores

	var total_score = resultManager.total_score()
	get_node("CanvasLayer/Score/Label").text = str(total_score) + "%"

	for i in range(0, tattoos.size()):
		add_frame(positions[i], tattoos[i], scores[i])

	if resultManager.set_highscore(total_score):
		pass # TODO effet new high score

	resultManager.save_game()


func _on_Menu_pressed():
	sceneManager.load_menu()

func _on_Replay_button_down():
	sceneManager.load_game()
