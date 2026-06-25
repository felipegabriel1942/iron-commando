extends CharacterBody2D
class_name EnemyAPC

@onready var machine_gun_animated_sprite_2d: AnimatedSprite2D = $MachineGunAnimatedSprite2D
@onready var veicule_animated_sprite_2d: AnimatedSprite2D = $VeiculeAnimatedSprite2D

func _on_died() -> void:
	queue_free()

func _on_damaged(damage_data: Variant) -> void:
	GameFeelManager.hit_stop(1)
	GameFeelManager.flash_shader(machine_gun_animated_sprite_2d)
	GameFeelManager.flash_shader(veicule_animated_sprite_2d)

func _on_health_changed(current: Variant, max: Variant) -> void:
	print(current)
