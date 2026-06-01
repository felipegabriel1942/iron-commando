extends Node2D
class_name WorldObject

func _on_hurtbox_entered(area: Area2D) -> void:
	await get_tree().physics_frame
	await get_tree().physics_frame
	
	if is_instance_valid(area):
		if area is Projectile:
			if !area.origin_cover:
				if randf() < 0.5:
					area.queue_free()
			else:
				area.origin_cover = false

func _on_cover_exited(area: Area2D) -> void:
	if area is Projectile:
		area.origin_cover = false
