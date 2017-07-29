tool
extends Sprite

export(int, "Right", "Left", "Up", "Down") var facing = 0 setget facing_set
export(int, "On", "Off", "Flickering") var light = 0 setget light_toggle

var lamp_right = preload("res://Assets/Art/Tiles/Streets/lamp_right.png")
var lamp_left = preload("res://Assets/Art/Tiles/Streets/lamp_left.png")
var lamp_up = preload("res://Assets/Art/Tiles/Streets/lamp_up.png")
var lamp_down = preload("res://Assets/Art/Tiles/Streets/lamp_down.png")
var light_1 = preload("res://Assets/Art/Tiles/Streets/lamp_light.png")
var light_2 = preload("res://Assets/Art/Tiles/Streets/lamp_light_2.png")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func light_toggle(value):
	light = value
	if light == 0:
		if get_node("Light"):
			get_node("Light").set_opacity(1)
			get_node("Light").flicker = false
	elif light == 1:
		if get_node("Light"):
			get_node("Light").set_opacity(0)
			get_node("Light").flicker = false
	elif light == 2:
		if get_node("Light"):
			get_node("Light").set_opacity(1)
			get_node("Light").flicker = true

func facing_set(value):
	facing = value
	if facing == 0:
		set_texture(lamp_right)
		set_offset(Vector2(14, -36))
		if get_node("Light"):
			get_node("Light").set_texture(light_1)
			get_node("Light").set_pos(Vector2(19, -69))
			get_node("Light").set_flip_h(false)
			get_node("Light").set_z(0)
	elif facing == 1:
		set_texture(lamp_left)
		set_offset(Vector2(-12, -36))
		if get_node("Light"):
			get_node("Light").set_texture(light_1)
			get_node("Light").set_pos(Vector2(-17, -69))
			get_node("Light").set_flip_h(true)
			get_node("Light").set_z(0)
	elif facing == 2:
		set_texture(lamp_up)
		set_offset(Vector2(1, -35))
		if get_node("Light"):
			get_node("Light").set_texture(light_2)
			get_node("Light").set_pos(Vector2(1, -58))
			get_node("Light").set_flip_h(false)
			get_node("Light").set_z(0)
	elif facing == 3:
		set_texture(lamp_down)
		set_offset(Vector2(1, -35))
		if get_node("Light"):
			get_node("Light").set_texture(light_2)
			get_node("Light").set_pos(Vector2(1, -55))
			get_node("Light").set_flip_h(false)
			get_node("Light").set_z(0)

