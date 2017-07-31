extends Node2D

signal skating_start
signal skating_end

export var walk_speed = 50

const MASS = 3
var max_skate_speed = 500
var skate_acceleration = 1800
var skate_deceleration = 1800
var skate_speed = 0
var steering = Vector2()
var motion = Vector2()
var target_motion = Vector2()

onready var position = get_pos()
var direction = Vector2()
var next_dir = Vector2()
var skating = false
var can_skate = true
var exit_leave = false

var delta_time = Vector2()

onready var area = get_node("Area2D")
func _ready():
	set_process(true)

func _process(delta):
	delta_time = Vector2(delta_time.x + delta, delta)
#	set_pos(position.snapped(Vector2(1,1)))
	
	if not skating:
		if direction.length() != 0:
			position += direction.normalized() * delta * walk_speed
#			set_pos(position.snapped(Vector2(1, 1)))
			set_pos(position)
	else:
		if next_dir.length() != 0 and not exit_leave:
			skate_speed += skate_acceleration * delta
		else:
			skate_speed -= skate_deceleration * delta
		
		skate_speed = clamp(skate_speed, 0, max_skate_speed)
		
		target_motion = skate_speed * next_dir.normalized() * delta
		steering = target_motion - motion
	
		if steering.length() > 1:
			steering = steering.normalized()
			
		motion += steering / MASS
		
		if skate_speed == 0 and not exit_leave:
			motion = Vector2()
		elif skate_speed == 0 and exit_leave:
			skating = false
			emit_signal("skating_end")
		
		position += motion
#		set_pos(position.snapped(Vector2(1,1)))
		set_pos(position)
#
#	var direction = Vector2()
#	var speed = 0
#	var acceleration = 1800
#	var decceleration = 3000
#	
#	var motion = Vector2()
#	var target_motion = Vector2()
#	var steering = Vector2()
#	const MASS = 2
#	
#	const MAX_SPEED = 600
#	
#	var Skin = null
#	var target_angle = 0
#	
#	func _ready():
#		Skin = get_node("Sprite")
#		set_fixed_process(true)

#	if direction != Vector2():
#		speed += acceleration * delta
#	else:
#		speed -= decceleration * delta
#
#	speed = clamp(speed, 0, MAX_SPEED)
#	
#	target_motion = speed * direction.normalized() * delta
#	steering = target_motion - motion
#
#	if steering.length() > 1:
#		steering = steering.normalized()
#	
#	motion += steering / MASS
#
#	if speed == 0:
#		motion = Vector2()
#
#	move(motion)
#	if motion != Vector2():
#		target_angle = atan2(motion.x, motion.y) - PI/2
#		Skin.set_rot(target_angle)
#

func _on_Input_processed( type, value ):
	if type == "direction":
		if not skating:
			direction = value
		else:
			next_dir = value
	if type == "action" and value == "pressed":
		if can_skate and not skating:
			for a in area.get_overlapping_bodies():
				if not a.get_name().begins_with("Tile"):
					skating = true
					emit_signal("skating_start")
					next_dir = direction
					motion = direction.normalized() * delta_time.y * walk_speed
		elif skating:
			skating = false
			emit_signal("skating_end")

func _on_Area2D_body_enter( body ):
	if not body.get_name().begins_with("Tile"):
#		can_skate = true
		exit_leave = false
		pass

func _on_Area2D_body_exit( body ):
	if not body.get_name().begins_with("Tile") and skating:
		exit_leave = true
		for a in area.get_overlapping_bodies():
			if not a.get_name().begins_with("Tile") and a != body:
				exit_leave = false
	elif not body.get_name().begins_with("Tile") and not skating:
#		can_skate = false
		exit_leave = false
		pass
#	skating = false
#	direction = next_dir	
