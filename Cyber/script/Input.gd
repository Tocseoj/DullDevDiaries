extends Node

signal processed(type, value)

func _ready():
	set_process_input(true)

var input_direction = Vector2()

func _input(event):
	if event.is_action_pressed("action_0"):
		emit_signal("processed", "action", "pressed")
		return
	
	if event.is_action_released("move_left"):
		input_direction.x = (1 if Input.is_action_pressed("move_right") else 0)
	elif event.is_action_released("move_right"):
		input_direction.x = (-1 if Input.is_action_pressed("move_left") else 0)
	elif event.is_action_released("move_up"):
		input_direction.y = (1 if Input.is_action_pressed("move_down") else 0)
	elif event.is_action_released("move_down"):
		input_direction.y = (-1 if Input.is_action_pressed("move_up") else 0)

	elif event.is_action_pressed("move_left"):
		if not Input.is_action_pressed("move_right"):
			input_direction.x = -1
	elif event.is_action_pressed("move_right"):
		if not Input.is_action_pressed("move_left"):
			input_direction.x = 1
	elif event.is_action_pressed("move_up"):
		if not Input.is_action_pressed("move_down"):
			input_direction.y = -1
	elif event.is_action_pressed("move_down"):
		if not Input.is_action_pressed("move_up"):
			input_direction.y = 1
	
	emit_signal("processed", "direction", input_direction)
