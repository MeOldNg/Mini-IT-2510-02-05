extends CharacterBody2D

@onready var player: CharacterBody2D = $"."

const default_speed = 150
@export var speed := 150
@export var acceleration :=15.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var interactable: RayCast2D = $interactable

var animation_direction: String = "down"
var animation_state: String = "Idle"
var is_holding_something = false

func reparented():
	print("new parent is", get_parent())
	
func _physics_process(_delta: float) -> void:
	if $interactable.is_colliding(): # these are interactable codes
		var collider = $interactable.get_collider()
		if collider.interact_type == "click":
			if Input.is_action_just_pressed("ui_accept"):
				collider.on_interact()
		elif collider.interact_type == "hold":
			if Input.is_action_just_pressed("ui_accept"):
				if collider.box:
					is_holding_something =true
					collider.global_position = interactable.target_position * interactable.global_transform
					print("must be held")
			elif Input.is_action_just_released("ui_accept"):
				is_holding_something =false
				print("I let go")
		else:
			print("somethings wrong")


	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		animation_direction = "up"
		input_vector.y = -1
		if not is_holding_something:
			interactable.target_position = Vector2.UP * 32
			interactable.force_raycast_update()
	elif Input.is_action_pressed("move_down"):
		animation_direction = "down"
		input_vector.y = 1
		if not is_holding_something:
			interactable.target_position = Vector2.DOWN * 32
			interactable.force_raycast_update()
	elif Input.is_action_pressed("move_left"):
		input_vector.x = -1
		animation_direction = "side"
		$AnimatedSprite2D.flip_h = true
		if not is_holding_something:
			interactable.target_position = Vector2.LEFT * 24
			interactable.force_raycast_update()
	elif Input.is_action_pressed("move_right"):
		animation_direction = "side"
		$AnimatedSprite2D.flip_h = false
		input_vector.x = 1
		if not is_holding_something:
			interactable.target_position = Vector2.RIGHT * 24
			interactable.force_raycast_update()
	else:
		velocity = Vector2.ZERO
	velocity = input_vector * speed
	move_and_slide()
	var _direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if velocity != Vector2.ZERO:
		animation_state = "move"
	else:
		animation_state = "Idle"
	animated_sprite_2d.play(animation_state+animation_direction)

func heating(temp):
	if temp == "hot":
		speed = 150
		print("im in heatzone")
	if temp == "cold":
		speed = 75
		print("im in coldzone")

	


#height = 32
#width = 19
