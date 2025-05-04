extends CharacterBody2D

@onready var tile_map = $"../dungeon_tiles"
@onready var sprite_2d = $Sprite2D
var is_moving = false
#
func _physics_process(delta: float) -> void:
	if is_moving == false:
		return
	if global_position == sprite_2d.global_position:
		is_moving = false
		return
	sprite_2d.global_position = sprite_2d.global_position.move_toward(global_position, 1)

func _process(delta: float) -> void:
	#if is_moving:
		#return
	if Input.is_action_pressed("ui_up"):
		move(Vector2.UP)
	elif Input.is_action_pressed("ui_down"):
		move(Vector2.DOWN)
	elif Input.is_action_pressed("ui_left"):
		move(Vector2.LEFT)
	elif Input.is_action_pressed("ui_right")	:
		move(Vector2.RIGHT)

func move(direction: Vector2):
	#Get current tile Vector2i
	var current_tile: Vector2i = tile_map.local_to_map(global_position)
	#Get target tile Vector2i
	var target_tile = current_tile + Vector2i(direction)
	#Get custom data layer from target tile
	var tile_data: TileData = tile_map.get_cell_tile_data(target_tile)
	
	if tile_data.get_custom_data("walkable") == false:
		return

	#move player
	#is_moving = true
	
	global_position = tile_map.map_to_local(target_tile)
	move_and_slide()
	sprite_2d.global_position = tile_map.map_to_local(current_tile)

	
