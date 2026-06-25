extends Area2D
class_name HitboxComponent

signal on_hurtbox_hit(hurtbox)
signal on_body_hit(body)

var damage_data: DamageData

func hit(hurtbox: HurtboxComponent) -> void:
	damage_data.position = global_position	
	on_hurtbox_hit.emit(hurtbox)

func _on_body_entered(body: Node2D) -> void:
	on_body_hit.emit(body)
