extends Node2D

export var walk_speed = 50
export var rail_speed = 200

signal input

onready var pos = get_pos()
func _ready():
	set_process_input(true)
	set_process(true)

var input_direction = Vector2()
var on_rails = false

func _input(event):
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
	
	elif event.is_action_pressed("action_0"):
		jump()
	
	self.emit_signal("input")


func _process(delta):
	if not on_rails:
		if input_direction.length() != 0:
			pos += input_direction.normalized() * delta * walk_speed
			set_pos(pos.snapped(Vector2(1, 1)))
	else:
		set_offset(get_offset() + rail_speed * delta)

func jump():
	print("jump()")
	if not on_rails:
		var areas = get_node("Area2D").get_overlapping_areas()
		if not areas.empty():
			self.get_parent().remove_child(self)
			areas[0].get_parent().add_child(self)
			on_rails = true
	else:
		var no_path = self.get_parent().get_parent().get_node("No_Path")
		self.get_parent().remove_child(self)
		no_path.add_child(self)
		on_rails = false
