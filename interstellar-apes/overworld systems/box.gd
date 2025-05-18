extends CharacterBody2D
@onready var player: CharacterBody2D = $"../CharacterBody2D"

var interact_type = "hold"
var is_held = false
func on_interact():
	is_held = !is_held
	if is_held == true:
		global_position = player.global_position
		print("is holding")
	else:
		pass
	
