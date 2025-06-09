extends PathFollow2D
@onready var timer: Timer = $Timer
@onready var area_2d: Area2D = $Area2D
@onready var remote_transform_2d: RemoteTransform2D = $RemoteTransform2D

var direction = 1
func _physics_process(delta: float) -> void:
	progress += direction
	if progress_ratio >= 1 or progress_ratio <=0:
		if timer.time_left == 0:
			timer.start(5)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and body.get_parent() != self:
		body.call_deferred("reparent", self, true)
		print("reparented")

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player") and body.get_parent() != get_tree().root:
		body.call_deferred("reparent", get_tree().root, true)
		print("unparented")

func _on_timer_timeout() -> void:
	print("direction changed")
	direction = -direction
