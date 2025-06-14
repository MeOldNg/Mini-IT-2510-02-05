extends CharacterBody2D

enum states {patrol, alert, chase}
var target :Node = null
@export var group_name : String
var _direction : Vector2
var direction_tolerance: float = 10.0
var move_speed = 100
var positions : Array
var temp_positions : Array
var current_position : Marker2D
var state = states.patrol


func _ready() -> void:
	positions = get_tree().get_nodes_in_group(group_name)
	_get_positions()
	_get_next_position()

func _physics_process(_delta):
	var distance = target.global_position - global_position
	if abs(distance.x) > abs(distance.y) + direction_tolerance:
		if distance.x > 0:
			_direction.x = 1  # Move right
			rotation_degrees = 270
		else:
			_direction.x = -1  # Move left
			rotation_degrees = 90
	elif abs(distance.y) > abs(distance.x) + direction_tolerance:
		if distance.y > 0:
			_direction.y = 1  # Move down
			rotation_degrees = 0
		else:
			_direction.y = -1  # Move up
			rotation_degrees = 180
		
	_direction = _direction.normalized()
	velocity = _direction * move_speed
	print(_direction)
	move_and_slide()
	if states.patrol:
		target = current_position
	elif states.alert:
		print("animation goes here")
	elif states.chase:
		target = get_tree().get_first_node_in_group("player")

func _get_positions():
	temp_positions = positions.duplicate()
	
	
func _get_next_position():
	if temp_positions.is_empty():
		_get_positions()
	current_position = temp_positions.pop_front()
