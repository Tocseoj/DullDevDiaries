extends Node

onready var window_size = get_viewport().get_rect().size
onready var player = get_parent()
func _ready():
	_on_Player_moved()
	set_process(true)

var target_offset = Vector2()
var incremental_value = Vector2()
var prev_player_pos = Vector2()
var scale = 1

func _process(delta):
	var new_transform = get_viewport().get_canvas_transform()
	new_transform[2] = target_offset
	get_viewport().set_canvas_transform(new_transform)

func _on_Player_moved():
#	target_offset = -(player.get_pos()) + window_size / 2
#	target_offset = -(player.get_pos() + (player.get_pos() - prev_player_pos)) + window_size / 2
	
	# TODO: CAMERA
	if incremental_value.dot(player.input_direction) < 0:
		incremental_value = (incremental_value + 1 * player.input_direction).clamped(scale * 50)
	else:
		incremental_value = (incremental_value + 0.5 * player.input_direction).clamped(scale * 50)
	if player.on_rails:
		target_offset = -(player.get_parent().get_pos()) + window_size / 2
	else:
		target_offset = -(player.get_global_pos() + incremental_value) + window_size / 2

func _on_Game_new_scale(scale):
	window_size = Vector2(256, 224) * scale