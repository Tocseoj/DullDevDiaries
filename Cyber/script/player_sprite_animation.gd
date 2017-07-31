extends AnimatedSprite

var parts

func _ready():
	parts = get_children()
	parts.push_front(self)
	pass


func _on_Input_processed( type, value ):
	if type == "direction":
		if value.x == 0 && value.y == 0:
			for part in parts:
				part.play("idle" + get_animation().right(4))
		elif value.x == 1:
			for part in parts:
				part.play("walk_right")
		elif value.x == -1:
			for part in parts:
				part.play("walk_left")
		elif value.y == 1:
			for part in parts:
				part.play("walk_down")
		else:
			for part in parts:
				part.play("walk_up")

