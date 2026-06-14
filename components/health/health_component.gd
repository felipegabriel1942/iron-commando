extends Node2D
class_name HealthComponent

signal health_changed(current, max)
signal died

@export var max_health := 3

var current_health := max_health

func take_damage(amount: int):
	current_health -= amount
	
	health_changed.emit(current_health, max_health)
	
	if current_health <= 0:
		died.emit()
