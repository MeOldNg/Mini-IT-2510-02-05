extends PathFollow2D
@onready var timer: Timer = $Timer
@onready var area_2d: Area2D = $Area2D
@onready var remote_transform_2d: RemoteTransform2D = $RemoteTransform2D


var direction = 1
func _physics_process(delta: float) -> void:
	progress += direction
	if progress_ratio >= 1 or progress_ratio <=0:
		if timer.time_left == 0:
			$wallup/CollisionShape2D.disabled = true
			$walldown/CollisionShape2D.disabled = true
			$wallleft/CollisionShape2D.disabled = true
			$wallright/CollisionShape2D.disabled = true
			timer.start(5)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and body.get_parent() != self:
		body.call_deferred("reparent", self, true)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player") and body.get_parent() != get_tree().root:
		body.call_deferred("reparent", get_tree().root, true)

func _on_timer_timeout() -> void:
	$wallup/CollisionShape2D.disabled = false
	$walldown/CollisionShape2D.disabled = false
	$wallleft/CollisionShape2D.disabled = false
	$wallright/CollisionShape2D.disabled = false
	direction = -direction



#walldown.set_deferred("disabled",false)
#wallup.set_deferred("disabled",false)
#wallleft.set_deferred("disabled",false)
#wallright.set_deferred("disabled",false)
