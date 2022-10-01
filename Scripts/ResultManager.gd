extends Node2D

var tattoos
var scores

func _ready():
	reset()

func reset():
	tattoos = []
	scores = []

func add_tattoo(tattoo, score):
	tattoos += [tattoo]
	scores += [score]

func total_score():
	var total_score = 0
	for s in scores:
		total_score += s
	total_score /= scores.size()
	return total_score


var highscore_normal = 0
var highscore_hard = 0

func set_highscore_normal(s):
	if s > highscore_normal:
		highscore_normal = s
		return true
	return false

func set_highscore_hard(s):
	if s > highscore_hard:
		highscore_hard = s
		return true
	return false

var save_file = "user://savegame.save"

func save_game():
	var save_game = File.new()
	save_game.open(save_file, File.WRITE)
	save_game.store_line(to_json({
		"highscore_normal": highscore_normal,
		"highscore_hard": highscore_hard
		}))
	save_game.close()

func load_game():
	var save_game = File.new()
	if not save_game.file_exists(save_file):
		return

	save_game.open(save_file, File.READ)
	var data = parse_json(save_game.get_line())
	print(data)
	highscore_normal = data["highscore_normal"]
	highscore_hard = data["highscore_hard"]

	save_game.close()
