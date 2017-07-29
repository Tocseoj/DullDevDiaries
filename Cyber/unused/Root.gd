extends Node2D

var scale_factor = 1

func _ready():
	set_scale(Vector2(scale_factor, scale_factor))

func _on_Game_new_scale(scale):
	scale_factor = scale
	set_scale(Vector2(scale_factor, scale_factor))