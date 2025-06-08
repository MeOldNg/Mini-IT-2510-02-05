extends CharacterBody2D

const speed = 100


@export var target : Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

func _physics_process(delta: float) -> void:
	var vector = Vector2.ZERO
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	
	vector = Vector2.RIGHT.rotated(round(dir.angle() / TAU * 4) * TAU / 4).snapped(Vector2.ONE)
	velocity = vector * speed
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

# https://www.reddit.com/r/godot/comments/t206my/how_to_get_a_direction_from_a_vector2d/
