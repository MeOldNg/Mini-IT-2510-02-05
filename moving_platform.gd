extends PathFollow2D
@onready var timer: Timer = $Timer
@onready var area_2d: Area2D = $Area2D

var direction = 1
func _physics_process(delta: float) -> void:
	progress += direction
	if progress_ratio >= 1 or progress_ratio <=0:
		timer.start()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.get_parent() != self:
			body.get_parent().remove_child(body)
			call_deferred("addPlayerChild", body)
		
func addPlayerChild(body):
	self.add_child(body)


func _on_timer_timeout() -> void:
	direction = -direction
