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
