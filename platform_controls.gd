extends Path2D

var moving
@export var point1 : CollisionShape2D
@export var point2 : CollisionShape2D

func _physics_process(delta: float) -> void:
	point1.set_deferred("disabled", moving)
	point1.set_deferred("disabled", moving)
