extends Area2D
class_name AttackRangeComponent

var on_range := false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		on_range = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		on_range = false
