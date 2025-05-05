extends StaticBody2D

var open = true

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D



func on_interact():
	open = !open
	if open == false:
		sprite_2d.modulate = Color("red")
		set_collision_layer_value(3, true)
		print("CLOSED")
		print("Collision layer 1 is: %s" % get_collision_layer_value(1))
		print("Collision layer 2 is: %s" % get_collision_layer_value(2))
		print("Collision layer 3 is: %s" % get_collision_layer_value(3))
		print("Collision layer 4 is: %s" % get_collision_layer_value(4))
	
	if open == true:
		sprite_2d.modulate = Color("green")
		set_collision_layer_value(3, false)
		print("OPENED")
		print("Collision layer 1 is: %s" % get_collision_layer_value(1))
		print("Collision layer 2 is: %s" % get_collision_layer_value(2))
		print("Collision layer 3 is: %s" % get_collision_layer_value(3))
		print("Collision layer 4 is: %s" % get_collision_layer_value(4))
