extends StaticBody2D

enum type {ice, swamp, island}
enum states {closed, open}
@export var result : type
var state: states = states.closed
var interact_type = "click"

func _ready() -> void:
	$AnimatedSprite2D.play(str(state)+str(result))

func on_interact():
	if state == states.open:
		return
	state = states.open
	$AnimatedSprite2D.play(str(state)+str(result))
