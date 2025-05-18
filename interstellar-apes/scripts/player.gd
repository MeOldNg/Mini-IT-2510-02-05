extends CharacterBody2D


@export var SPEED := 300
@export var acceleration :=15.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var interactable: RayCast2D = $interactable

var animation_direction: String = "down"
var animation_state: String = ""
var is_holding_something = false

func update_sprite_direction(input: Vector2) -> void:
	match input:
		Vector2.DOWN:
			animation_direction = "move_down"
			if not is_holding_something:
				interactable.target_position = Vector2.DOWN * 20
				interactable.force_raycast_update()
		Vector2.UP:
			animation_direction = "move_up"
			if not is_holding_something:
				interactable.target_position = Vector2.UP * 20
				interactable.force_raycast_update()
		Vector2.RIGHT:
			animation_direction = "move_right"
			if not is_holding_something:
				interactable.target_position = Vector2.RIGHT * 20
				interactable.force_raycast_update()
		Vector2.LEFT:
			animation_direction = "move_left"
			if not is_holding_something:
				interactable.target_position = Vector2.LEFT * 20
				interactable.force_raycast_update()
 
 

func update_sprite() -> void:
	if velocity.length() > 0:
		animation_state > "move"
	else:
		animation_state > "Idle"
 
func _physics_process(delta: float) -> void:
	if $interactable.is_colliding():
		var collider = $interactable.get_collider()
		if collider.interact_type == "click":
			if Input.is_action_just_pressed("ui_accept"):
				collider.on_interact()
		elif collider.interact_type == "hold":
			if Input.is_action_just_pressed("ui_accept"):
				is_holding_something =true
				print("must be held")
			elif Input.is_action_just_released("ui_accept"):
				is_holding_something =false
				print("I let go")
		else:
			print("somethings wrong")
	
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	update_sprite_direction(direction)
	update_sprite()
	
	
	animated_sprite_2d.play(animation_state+animation_direction)
	
	velocity.x = move_toward(velocity.x, direction.x*SPEED, acceleration)
	velocity.y = move_toward(velocity.y, direction.y*SPEED, acceleration)
	
	move_and_collide(velocity*delta)
	
func resume():
	get_tree().paused = false
	
func paused():
	get_tree().paused = true
	
func Esc():
	if Input.is_action_just_pressed("esc"):
		get_tree().change_scene_to_file("res://main-menu/mainmenuscene/in-game_paused.tscn")
