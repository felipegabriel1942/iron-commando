extends Node2D
class_name MuzzleFlash

func _on_animation_finished() -> void:
	queue_free()
