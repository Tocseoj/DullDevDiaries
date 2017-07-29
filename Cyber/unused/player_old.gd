extends Node2D

signal moved

onready var anim = get_node("AnimatedSprite")
func _ready():
	set_process_input(true)
	set_process(true)

var input_direction = Vector2()
var stopped = true
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
	
	if input_direction == Vector2():
		anim.play("idle" + anim.get_animation().right(4))
	elif input_direction.x == 1:
		anim.play("walk_right")
	elif input_direction.x == -1:
		anim.play("walk_left")
	elif input_direction.y == 1:
		anim.play("walk_down")
	else:
		anim.play("walk_up")
	
	if event.is_action_pressed("action_0"):
		jump()

func _process(delta):
	if not on_rails:
		if input_direction.length() != 0:
			set_pos(get_pos() + input_direction)
	#		set_pos((get_pos() + (input_direction.normalized() * delta * 50)) \
	#		.snapped(Vector2(1,1)))
			self.emit_signal("moved")
			stopped = false
		elif not stopped:
			self.emit_signal("moved")
			stopped = true
	else:
		get_parent().set_offset(get_parent().get_offset() + 4)

func jump():
	if not on_rails:
		var areas = get_node("Area2D").get_overlapping_areas()
		if not areas.empty():
			self.get_parent().remove_child(self)
			areas[0].get_parent().get_node("PathFollow2D").add_child(self)
			set_pos(Vector2(0, 0))
			on_rails = true
	else:
		var pos = get_parent().get_pos()
		var Paths = self.get_parent().get_parent().get_parent()
		self.get_parent().remove_child(self)
		Paths.add_child(self)
		on_rails = false
		set_pos(pos)