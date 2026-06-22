extends Node2D
class_name HealthComponent

signal health_changed(current, max)
signal died

@export var max_health := 3

var current_health: int

func _ready() -> void:
	current_health = max_health

func take_damage(amount: int) -> void:
	current_health -= amount
	
	health_changed.emit(current_health, max_health)
	
	if current_health <= 0:
		died.emit()

func heal(amount: int) -> void:
	current_health += amount
	
	if current_health > max_health:
		current_health = max_health
	
	health_changed.emit(current_health, max_health)

func is_full_health() -> bool:
	return current_health == max_health
