tool
extends Node

export(bool) var move_tiles = true setget move_set
export(Vector2) var tile_size = Vector2(4096, 4096)

func move_set(value):
	move_tiles = value
	var tiles = self.get_children()
	for tile in tiles:
		if move_tiles:
			tile.set_pos(Vector2(tile.get_name()[5].to_int() * tile_size.x, \
								tile.get_name()[7].to_int() * tile_size.y))
		else:
			tile.set_pos(Vector2())