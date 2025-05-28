extends CharacterBody2D

const speed = 100


@export var target : Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

func _physics_process(delta: float) -> void:
	var vector = Vector2.ZERO
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	var direction = atan2(dir.y, dir.x)
	print(rad_to_deg(direction))
	if round(direction) == -2:
		vector.y -= 1 #up
	if round(direction) == 2:
		vector.y += 1 #down
	if round(direction) == 0:
		vector.x += 1 # left
	if round(direction) == 3:
		vector.x -= 1 #right

	#if rad_to_deg(direction) 
	
	#velocity = dir * speed
	velocity = vector * speed
	move_and_slide()
	if global_position.distance_to(nav_agent.target_position) < 10:
		nav_agent.get_next_path_position()

func makepath() -> void:
	nav_agent.target_position = target.global_position

func _on_timer_timeout() -> void:
	makepath()
