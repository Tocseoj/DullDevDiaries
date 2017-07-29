extends Node2D

var direction = Vector2()

func _ready():
	set_process(true)

func _process(delta):
	set_pos(get_pos() + direction)


func _on_Input_processed( type, value ):
	if type == "direction":
		direction = value
