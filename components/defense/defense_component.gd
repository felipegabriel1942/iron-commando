extends Node
class_name DefenseComponent

@export var weakness: DamageType.Type
@export var resistence: DamageType.Type

func calculate_damage(damage_data: DamageData) -> int:
	var damage = damage_data.damage
	
	if damage_data.type == weakness:
		damage *= 2
		
	if damage_data.type == resistence:
		damage = max(1, damage / 2)
	
	print(damage)
		
	return damage
