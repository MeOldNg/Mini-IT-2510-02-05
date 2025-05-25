extends CharacterBody2D
class_name enemy
const speed = 100

var target


func _physics_process(_delta: float) -> void:
	var vector = Vector2.ZERO

	if position.y - target.position.y < -1:
		vector.y += 1
	elif position.y - target.position.y > 1:
		vector.y -= 1
	elif position.x - target.position.x < -1:
		vector.x += 1
	elif position.x - target.position.x > 1:
		vector.x -= 1
	velocity = vector * speed
	
	move_and_slide()
	#print(target.position)
