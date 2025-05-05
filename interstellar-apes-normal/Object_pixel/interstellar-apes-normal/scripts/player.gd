extends CharacterBody2D


@export var SPEED := 300
@export var acceleration :=10.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var animation_direction: String = "down"
var animation_state: String = ""


func update_sprite_direction(input: Vector2) -> void:
	match input:
		Vector2.DOWN:
			animation_direction = "move_down"
		Vector2.UP:
			animation_direction = "move_up"
		Vector2.RIGHT:
			animation_direction = "move_right"
		Vector2.LEFT:
			animation_direction = "move_left"
 
 

func update_sprite() -> void:
	if velocity.length() > 0:
		animation_state > "move"
	else:
		animation_state > "Idle"
 
func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	update_sprite_direction(direction)
	update_sprite()
	
	
	animated_sprite_2d.play(animation_state+animation_direction)
	
	velocity.x = move_toward(velocity.x, direction.x*SPEED, acceleration)
	velocity.y = move_toward(velocity.y, direction.y*SPEED, acceleration)
	
	move_and_collide(velocity*delta)
