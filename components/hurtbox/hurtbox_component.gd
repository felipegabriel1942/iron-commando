extends Area2D
class_name HurtboxComponent

signal damaged(damage_data)

@export var health_component: HealthComponent
@export var knockback_component: KnockbackComponent
@export var defense_component: DefenseComponent
@export var invincibility_duration := 0.5

var invincible := false

func receive_hit(damage_data: DamageData) -> void:
	if invincible:
		return
	
	var damage = defense_component.calculate_damage(damage_data)
	
	health_component.take_damage(damage)
	
	if knockback_component:
		knockback_component.apply_knockback(
			damage_data.direction,
			damage_data.knockback_force
		)
	
	damaged.emit(damage_data)
	
	start_invincibility()
	
func start_invincibility() -> void:
	invincible = true
	
	await get_tree().create_timer(invincibility_duration).timeout
	
	invincible = false
