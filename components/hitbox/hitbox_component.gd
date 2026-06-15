extends Area2D
class_name HitboxComponent

var damage_data: DamageData

func hit(hurtbox: HurtboxComponent) -> void:
	damage_data.position = global_position
	hurtbox.receive_hit(damage_data)
	
	get_parent().queue_free()
