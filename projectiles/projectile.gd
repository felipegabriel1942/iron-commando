extends Area2D
class_name Projectile

var direction := Vector2.ZERO
var speed := 250.0

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

func _on_screen_exited() -> void:
	queue_free()
