extends Node
class_name finitestatemachine

var states : Dictionary = {}
@export var initial_state : State

var current_state

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_transition.connect(change_state)
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func change_state(source_state : State, new_state_name : String):
	if source_state != current_state:
		print("Invalid change_state trying from: " + source_state.name + " but currently in: " + current_state.name)
		return
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		print("new state is empty")
		return
	if current_state:
		current_state.exit()
	new_state.enter()
	
	current_state = new_state

func _process(delta):
	if current_state:
		current_state.update(delta)
