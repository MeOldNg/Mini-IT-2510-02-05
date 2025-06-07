extends CharacterBody2D

enum states {patrol, alert, chase}
@export var group_name : String
@onready var tile_map : TileMapLayer
@onready var target = get_tree().get_nodes_in_group("player")
var current_path : Array[Vector2i]
var temp_posititions : Array #temporary var to store positions
var positions : Array #positions for wandering
var current_position : Marker2D #current position
var speed = 3
func _ready() -> void:
	positions = get_tree().get_nodes_in_group(group_name)
	get_positions()
	get_next_position()

func _physics_process(delta: float) -> void:
	if current_path.is_empty():
		return
	var target_position = tile_map.map_to_local(current_path.front())
	global_position = global_position.move_toward(target_position, speed)
	if global_position == target_position:
		current_path.pop_front()
	if states.patrol:
		if tile_map.is_point_walkable(current_position.global_position):
			current_path = tile_map.astar.get_id_path(
				tile_map.local_to_map(global_position),
				tile_map.local_to_map(current_position.global_position)
			).slice(1)
		if global_position.distance_to(current_position.global_position) < 10:
			get_next_position()
	elif states.chase:
		pass


func get_positions():
	temp_posititions= positions.duplicate()
	
func get_next_position():
	if temp_posititions.is_empty():
		get_positions()
	current_position = temp_posititions.pop_front()
