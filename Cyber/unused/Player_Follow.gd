extends PathFollow2D

var on_rails = false

func _ready():
	set_process(true)
	get_node("Player").connect("move", self, "player_move")
	get_node("Player").connect("jump", self, "player_jump")

func _process(delta):
	if on_rails:
		set_offset(get_offset() + 1)

func player_move(direction):
	if not on_rails:
		set_pos(get_pos() + direction)

func player_jump():
	on_rails = not on_rails