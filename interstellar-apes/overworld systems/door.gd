extends StaticBody2D

var open = false

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var interact: CollisionShape2D = $collision_interact



func on_interact():
	print(get_collision_layer_value(2))
	open = !open
	if open == false:
		sprite_2d.modulate = Color("red")
		set_collision_layer_value(2, true)
		set_collision_mask_value(2, true)
	else:
		sprite_2d.modulate = Color("green")
		set_collision_layer_value(2, false)
		set_collision_mask_value(2, false)
