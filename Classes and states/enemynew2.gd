extends CharacterBody2D

enum states {patrol, alert, chase}

var move_speed = 150
var state: states = states.patrol
@export var group_name : String
@export var target : Node = null
var _direction : Vector2
var direction_tolerance: float = 10.0
var positions : Array #positions for wandering
var temp_posititions : Array #temporary var to store positions
var current_position : Marker2D #current position

func _physics_process(delta: float) -> void:
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
	move_and_slide()
	if state == states.patrol:
		if global_position.distance_to(target.position) < 50:
			get_next_position()
			
func change_target(received_target):
	target = received_target


func _ready() -> void:
	#$NavigationAgent2D.target_position = target.position
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
	print (current_position.global_position)


func _on_sights_body_entered(body: Node2D) -> void:
	
	pass # Replace with function body.
