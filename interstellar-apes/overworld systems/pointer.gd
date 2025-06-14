extends Node2D

func _physics_process(delta: float) -> void:
	var dir = to_local(get_global_mouse_position()).normalized()
	var direction = atan2(dir.y, dir.x)
	look_at(get_global_mouse_position())
	print(dir)
