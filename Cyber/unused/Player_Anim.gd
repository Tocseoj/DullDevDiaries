extends AnimatedSprite

onready var player = get_parent()

func _on_Player_input():
	if player.input_direction == Vector2():
		self.play("idle" + self.get_animation().right(4))
	elif player.input_direction.x == 1:
		self.play("walk_right")
	elif player.input_direction.x == -1:
		self.play("walk_left")
	elif player.input_direction.y == 1:
		self.play("walk_down")
	else:
		self.play("walk_up")