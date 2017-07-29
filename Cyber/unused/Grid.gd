extends Node2D

var tile_size
var half_tile_size

var grid_size = Vector2()
var grid = []

enum GRID_TYPES {EMPTY, CURB_LEFT, CURB_RIGHT, CURB_UP, CURB_DOWN,     \
					CURB_CORNER_TOP_LEFT, CURB_CORNER_TOP_RIGHT,       \
					CURB_CORNER_BOTTOM_LEFT, CURB_CORNER_BOTTOM_RIGHT}

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func get_tile(pos):
	var tile = Vector2(pos.x / 4096, pos.y / 4096).floor()
	var map = get_node(str("tile_", tile.x, "_", tile.y, "/Tile Layer 1"))
	var current_cell = map.world_to_map(pos)
	print(map.get_cellv(current_cell))