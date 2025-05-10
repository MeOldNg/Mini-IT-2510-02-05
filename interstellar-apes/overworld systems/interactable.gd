extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D



func on_interact():
	sprite_2d.rotate(10)
