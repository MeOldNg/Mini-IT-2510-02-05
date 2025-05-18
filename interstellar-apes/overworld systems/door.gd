extends StaticBody2D

var interact_type = "click"
var open = false
@onready var sprite: Sprite2D = $Sprite2D

func on_interact():
	open = !open
	if open:
		set_collision_layer_value(2, false)
		sprite.modulate = Color("green")
	if not open:
		set_collision_layer_value(2, true)
		sprite.modulate = Color("red")
	
	
	print("interacted")
	
