extends CharacterBody2D

enum states {patrol, alert, chase}

var speed = 100
var state: states = states.patrol
@export var group_name : String
@export var target : Node = null

var positions : Array #positions for wandering
var temp_posititions : Array #temporary var to store positions
var current_position : Marker2D #current position

func _physics_process(delta: float) -> void:
	print(self.global_position)
	var vector = Vector2.ZERO
	if position.y - target.position.y < -1:
		vector.y += 1
		rotation_degrees = 0
	elif position.y - target.position.y > 1:
		vector.y -= 1
		rotation_degrees = 180
	elif position.x - target.position.x < 1:
		vector.x += 1
		rotation_degrees = 270
	elif position.x - target.position.x > -1:
		vector.x -= 1
		rotation_degrees = 90
	velocity = vector * speed
	move_and_slide()
	if state == states.patrol:
		if global_position.distance_to(target.position) < 10:
			get_next_position()
			
func change_target(received_target):
	target = received_target


func _ready() -> void:
	$NavigationAgent2D.target_position = target.position
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
	print (current_position.position)


func _on_sights_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	target = body
	state = states.chase
