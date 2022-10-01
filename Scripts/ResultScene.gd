extends Node2D

onready var sceneManager = get_node("../")
onready var resultManager = get_node("../ResultManager")

var tattooFrame = preload("res://Scenes/TattooFrame.tscn")

var positions = [
	Vector2(-750,-500),
	Vector2(-250,-500),
	Vector2(250,-500),
	Vector2(750,-500),
	Vector2(-750,-100),
	Vector2(-250,-100),
	Vector2(250,-100),
	Vector2(750,-100),
	Vector2(-750,300),
	Vector2(-250,300),
	Vector2(250,300),
	Vector2(750,300),
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

	if resultManager.set_highscore_normal(total_score):
		pass # TODO effet new high score

	resultManager.save_game()

func _on_Replay_pressed():
	sceneManager.load_game()

func _on_Menu_pressed():
	sceneManager.load_menu()

func _on_ReplayHard_pressed():
	sceneManager.load_game(true)
