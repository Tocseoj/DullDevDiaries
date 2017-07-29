extends Sprite

func _ready():
	set_process(true)

func _process(delta):
	if get_pos().x >= 300:
		set_pos(Vector2(27, -29))
	if get_pos().y >= 95:
		set_pos(get_pos() + Vector2(delta * 200, 0))
	else:
		set_pos(get_pos() + Vector2(0, delta * 200))