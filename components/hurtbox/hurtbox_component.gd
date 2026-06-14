extends Area2D
class_name HurtboxComponent

signal damaged(damage_data)

@export var health_component: HealthComponent

func receive_hit(damage_data: DamageData) -> void:
	health_component.take_damage(damage_data.damage)
	
	damaged.emit(damage_data)
