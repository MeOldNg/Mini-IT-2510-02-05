extends StaticBody2D

var interact_type = "click"
var lit = false
@onready var heat: Area2D = $heat
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	if lit:
		$heat/CollisionShape2D.disabled = false
		sprite.play("lit")
	elif not lit:
		$heat/CollisionShape2D.disabled = true
		sprite.play("unlit")

func on_interact():
	lit = !lit


func _on_heat_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.heating("hot")

func _on_heat_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
			body.heating("cold")
