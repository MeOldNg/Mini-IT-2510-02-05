extends CharacterBody2D
class_name enemy
const speed = 100

enum states {patrol, alert, chase}
@export var group_name : String
var target 
var state: states = states.patrol
var positions : Array #positions for wandering
var temp_posititions : Array #temporary var to store positions
var current_position : Marker2D #current position


func _physics_process(_delta: float) -> void:
	var vector = Vector2.ZERO
	if position.y - target.position.y < -1:
		vector.y += 1
	elif position.y - target.position.y > 1:
		vector.y -= 1
	elif position.x - target.position.x < -1:
		vector.x += 1
	elif position.x - target.position.x > 1:
		vector.x -= 1
	velocity = vector * speed
	move_and_slide()
	#print(target.position)

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
