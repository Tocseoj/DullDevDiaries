extends Control

export(int) var width  = 256
export(int) var height = 224

signal new_scale(scale)

var player_cam

func _ready():
	set_process(true)
	player_cam = find_node("Player").get_node("Camera")
	connect("new_scale", player_cam, "_on_Game_new_scale")
	
var scale_factor = 1

func _process(delta):
	var window_size = OS.get_window_size()
	var new_scale_factor = floor(min(window_size.width / width, window_size.height / height))
	if new_scale_factor < 1: new_scale_factor = 1
	if scale_factor != new_scale_factor:
		scale_factor = new_scale_factor
		emit_signal("new_scale", scale_factor)
		self.set_margin(MARGIN_LEFT, (scale_factor * width) / 2)
		self.set_margin(MARGIN_TOP, (scale_factor * height) / 2)
		self.set_margin(MARGIN_RIGHT, -((scale_factor * width) / 2))
		self.set_margin(MARGIN_BOTTOM, -((scale_factor * height) / 2))
