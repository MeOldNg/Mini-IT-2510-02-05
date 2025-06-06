extends TileMapLayer

var astargrid = AStarGrid2D.new()
var map_rect = Rect2i()

func _ready() -> void:
	
	var tilemap_size = get_used_rect().end - get_used_rect().position
	var tile_size = get_tile_set().tile_size
	
	map_rect = Rect2i(Vector2i.ZERO, tilemap_size)
	astargrid.region = map_rect
	astargrid.cell_size = tile_size
	astargrid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astargrid.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astargrid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astargrid.update()
	
	for i in tilemap_size.x:
		for j in tilemap_size.y:
			var coords = Vector2i(i,j)
			var tile_data = get_cell_tile_data(coords)
			if tile_data and tile_data.get_custom_data('walkable') == false:
				astargrid.set_point_solid(coords)

func is_point_walkable(position):
	var map_position = local_to_map(position)
	if map_rect.has_point(map_position) and not astargrid.is_point_solid(map_position):
		return true
	else:
		print("Can't fucking get there")
		return false
