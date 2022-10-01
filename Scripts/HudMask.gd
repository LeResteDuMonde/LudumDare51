extends Node2D

onready var white_mask := $WhiteMask

func new_model():
	white_mask.scale = Vector2(2,2)
	var tween := create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween.tween_property(white_mask, "scale", Vector2(2,0) , 1)
