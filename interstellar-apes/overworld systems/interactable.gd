extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var tile_map: TileMapLayer = $"../dungeon_tiles"

func ready():
	var current_tile: Vector2i = tile_map.local_to_map(global_position)
	var tile_data: TileData = tile_map.get_cell_tile_data(current_tile)
	if tile_data.get_custom_data("walkable") == true:
		tile_data.set_custom_data("walkable") = false

func on_interact():
	sprite_2d.rotate(10)
