extends CharacterBody2D

enum states {patrol, alert, chase}
@onready var exclamation: AnimatedSprite2D = $AnimatedSprite2D
@export var group_name : String
@export var target : CharacterBody2D
var _direction : Vector2
var direction_tolerance: float = 10.0
var positions : Array
var temp_positions : Array
var current_position : Marker2D
var state = states.patrol
var speed = 100
var spotted = false

func _ready() -> void:
	exclamation.hide()
	positions = get_tree().get_nodes_in_group(group_name)
	_get_positions()
	_get_next_position()

func change_state(newstate):
	state = newstate

func _physics_process(delta: float) -> void:
	match state:
		states.patrol:
			patrol()
		states.alert:
			alert()
		states.chase:
			chase()

func patrol():
	if global_position.distance_to(current_position.position) <10:
		_get_next_position()
	else:
		var vector = Vector2.ZERO
		if position.y - current_position.position.y < -1:
			vector.y += 1
			rotation_degrees = 0
		elif position.y - current_position.position.y > 1:
			vector.y -= 1
			rotation_degrees = 180
		elif position.x - current_position.position.x < 1:
			vector.x += 1
			rotation_degrees = 270
		elif position.x - current_position.position.x > 1:
			vector.x -= 1
			rotation_degrees = 90
		velocity = vector * speed
		move_and_slide()

func alert():
	exclamation.visible = true
	exclamation.play("alerted")
	if exclamation.animation_finished:
		exclamation.hide()
		change_state(states.chase)

func chase():
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
	velocity = _direction * speed
	move_and_slide()

func _get_positions():
	temp_positions = positions.duplicate()

func _get_next_position():
	if temp_positions.is_empty():
		_get_positions()
	current_position = temp_positions.pop_front()

func _on_sights_body_entered(body: Node2D) -> void:
	if not spotted:
		spotted = true
		change_state(states.alert)


func _on_crasher_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://interstellar-apes/Battle scene/Battle scene.tscn")
