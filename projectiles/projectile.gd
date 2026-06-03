extends Area2D
class_name Projectile

var direction := Vector2.ZERO
var speed := 250.0
var origin_cover := false

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

func _on_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	match body.name:
		"Walls":
			queue_free()
		"Objects":
			if !origin_cover and randf() < 0.5:
				queue_free()

func _on_area_exited(area: Area2D) -> void:
	if area.name.begins_with("CoverArea"):
		origin_cover = false
