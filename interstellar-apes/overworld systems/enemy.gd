extends CharacterBody2D
class_name enemy
const speed = 100

enum states {patrol, alert, chase}
@export var group_name : String
var target :Node = null
var _direction : Vector2
var direction_tolerance: float = 10.0
var state: states = states.patrol
var positions : Array #positions for wandering
var temp_posititions : Array #temporary var to store positions
var current_position : Marker2D #current position


func _physics_process(_delta: float) -> void:
	var distance = target.global_position - global_position
	if abs(distance.x) > abs(distance.y) + direction_tolerance:
		if distance.x > 0:
			_direction.x = 1  # Move right
		else:
			_direction.x = -1  # Move left
	elif abs(distance.y) > abs(distance.x) + direction_tolerance:
		if distance.y > 0:
			_direction.y = 1  # Move down
		else:
			_direction.y = -1  # Move up
		
	_direction = _direction.normalized()
	velocity = _direction * speed
	move_and_slide()

func ready():
	positions = get_tree().get_nodes_in_group(group_name)
	get_positions()
	get_next_position()

func get_positions():
	temp_posititions= positions.duplicate()
	
func get_next_position():
	if temp_posititions.is_empty():
		get_positions()
	current_position = temp_posititions.pop_front()
	change_target(current_position)
	
func change_target(received_target):
	target = received_target


func _on_sights_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	target = body
	state = states.chase
