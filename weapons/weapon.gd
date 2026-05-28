@abstract
class_name Weapon
extends Node2D

@export var data: WeaponData

@abstract func get_muzzle_position(facing_direction)
@abstract func shoot(owner, direction)

var can_shoot := true

func try_shoot(
	owner: CharacterBody2D,
	direction: Vector2
) -> void:
	if not can_shoot:
		return
		
	can_shoot = false
	
	shoot(owner, direction)
	
	start_fire_rate_cooldown(owner)

func start_fire_rate_cooldown(owner) -> void:
	await owner.get_tree().create_timer(data.fire_rate).timeout
	can_shoot = true
