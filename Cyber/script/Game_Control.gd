extends Control

export(int) var width =  256
export(int) var height = 224

signal scale_change(scale)

func _ready():
	get_tree().get_root().connect("size_changed", self, "screen_resize")
	screen_resize()

var game_scale = 1

func screen_resize():
	var new_size = get_viewport_rect().size
	var new_game_scale = floor(min(new_size.width / width, new_size.height / height))
	if new_game_scale < 1: new_game_scale = 1
	
	if game_scale != new_game_scale:
		game_scale = new_game_scale
#		self.set_size (Vector2(width,      height    ))
#		self.set_scale(Vector2(game_scale, game_scale))
#		self.set_pos((get_parent().get_size() - get_size() * game_scale) / 2)
		self.set_margin(MARGIN_LEFT,    ((game_scale * width ) / 2))
		self.set_margin(MARGIN_RIGHT,  -((game_scale * width ) / 2))
		self.set_margin(MARGIN_TOP,     ((game_scale * height) / 2))
		self.set_margin(MARGIN_BOTTOM, -((game_scale * height) / 2))
		emit_signal("scale_change", game_scale)