extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var tile_map: TileMapLayer = $"../dungeon_tiles"


func on_interact():
	sprite_2d.rotate(10)
