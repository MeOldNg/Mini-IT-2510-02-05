extends CharacterBody2D

@onready var sprite_2D: Sprite2D = $Sprite2D
pass
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	
	
