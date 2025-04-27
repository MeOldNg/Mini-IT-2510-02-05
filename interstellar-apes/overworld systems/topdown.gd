extends CharacterBody2D


#royal attributes
@export var speed = 200
@export var grid_size = 16
var target_position = Vector2.ZERO
var moving = false
@onready var tile_map: TileMapLayer = $"../dungeon_tiles"
@onready var ray_cast_2d = $RayCast2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var anim_dir
var direction
func _ready():
	#starts the target at the current location
	target_position = position
	print(direction)

func _physics_process(delta: float) -> void:
	#animation attempt
	if anim_dir == "left":
		if moving:
			animated_sprite_2d.play("walk_side")
			animated_sprite_2d.flip_h = true
		else:
			animated_sprite_2d.play("idle_side")
	if anim_dir == "right":
		if moving:
			animated_sprite_2d.play("walk_side")
			animated_sprite_2d.flip_h = false
		else:
			animated_sprite_2d.play("idle_side")
	if anim_dir == "up":
		if moving:
			animated_sprite_2d.play("walk_up")
			animated_sprite_2d.flip_h = true
		else:
			animated_sprite_2d.play("idle_up")
	if anim_dir == "down":
		if moving:
			animated_sprite_2d.play("walk_down")
			animated_sprite_2d.flip_h = true
		else:
			animated_sprite_2d.play("idle_down")

	#preset interaction
	if Input.is_action_just_pressed("ui_accept") and $RayCast2D.is_colliding():
		var collider = $RayCast2D.get_collider()
		collider.on_interact()
		
	if not moving:
		direction = Vector2.ZERO
		if Input.is_action_pressed("ui_up"):
			anim_dir = "up"
			move(Vector2.UP)
		elif Input.is_action_pressed("ui_down"):
			anim_dir = "down"
			move(Vector2.DOWN)
		elif Input.is_action_pressed("ui_left"):
			anim_dir = "left"
			move(Vector2.LEFT)
		elif Input.is_action_pressed("ui_right"):
			anim_dir = "right"
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
	
		if tile_data.get_custom_data("walkable") == false:
			#print("is colliding")
			return
		
		elif ray_cast_2d.is_colliding(): #checks if an entity is in the way
			#print("somethings in the way")
			return
		else: #lets player walk around
			#print("walkies")
			target_position += direction * grid_size
			moving = true
	print(ray_cast_2d.target_position)

#credits:
#https://www.reddit.com/r/godot/comments/13qgcwc/hiw_to_make_grid_based_movement/
#https://www.youtube.com/watch?v=lJT6XFw_-iA
#https://www.youtube.com/watch?v=9u1Dq6h7sGU&t=838s
