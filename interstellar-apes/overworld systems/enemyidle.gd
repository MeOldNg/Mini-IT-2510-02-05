extends State
class_name  enemy_idle

@export var group_name : String
@onready var enemy = $".."

var speed = 150
var positions : Array #positions for wandering
var temp_posititions : Array #temporary var to store positions
var current_position : Marker2D #current position


func enter():
	positions = get_tree().get_nodes_in_group(group_name)
	get_positions()
	get_next_position()

func exit():
	pass

func update(_delta:float):
	if enemy.global_position.distance_to(current_position.position) < 10:
		get_next_position()



func get_positions():
	temp_posititions= positions.duplicate()
	
func get_next_position():
	if temp_posititions.is_empty():
		get_positions()
	current_position = temp_posititions.pop_front()
	enemy.target_received(current_position)
	
