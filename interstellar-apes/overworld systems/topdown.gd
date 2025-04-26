extends CharacterBody2D


#royal attributes
@export var speed = 200
@export var grid_size = 16
var target_position = Vector2.ZERO
var moving = false
@onready var tile_map: TileMapLayer = $"../dungeon_tiles"
@onready var ray_cast_2d = $RayCast2D
var direction
func _ready():
	#starts the target at the current location
	target_position = position


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and $RayCast2D.is_colliding():
		var collider = $RayCast2D.get_collider()
		collider.on_interact()
		
	if not moving:
		direction = Vector2.ZERO
		if Input.is_action_pressed("ui_up"):
			move(Vector2.UP)
		elif Input.is_action_pressed("ui_down"):
			move(Vector2.DOWN)
		elif Input.is_action_pressed("ui_left"):
			move(Vector2.LEFT)
		elif Input.is_action_pressed("ui_right"):
			move(Vector2.RIGHT)


	if moving:
		position = position.move_toward(target_position, speed * delta)
		if position.distance_to(target_position) < speed * delta:
			position = target_position
			moving = false	
			
			
func move(direction: Vector2):
	
	if direction != Vector2.ZERO:
		ray_cast_2d.target_position = direction * 16
		ray_cast_2d.force_raycast_update()
		#Get current tile Vector2i
		var current_tile: Vector2i = tile_map.local_to_map(global_position)
		#Get target tile Vector2i
		var target_tile = current_tile + Vector2i(direction)
		#Get custom data layer from target tile
		var tile_data: TileData = tile_map.get_cell_tile_data(target_tile)
	
		if tile_data.get_custom_data("walkable") == false and ray_cast_2d.is_colliding() == false:
			print("fuck yeah")
			return
		else:
			print("walkies")
			target_position += direction * grid_size
			moving = true
			# the target position based on the direction and grid size

		#if tile_map.get_custom_data("walkable") == true:

#credits:
#https://www.reddit.com/r/godot/comments/13qgcwc/hiw_to_make_grid_based_movement/
#https://www.youtube.com/watch?v=lJT6XFw_-iA
#https://www.youtube.com/watch?v=9u1Dq6h7sGU&t=838s
