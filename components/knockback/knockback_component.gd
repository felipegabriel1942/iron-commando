extends Node2D
class_name KnockbackComponent

@export var hurtbox_component: Area2D
@export var knockback_force := 70

var knockback_velocity := Vector2.ZERO

func _ready() -> void:
	hurtbox_component.area_entered.connect(on_hurt)
	
func _physics_process(delta: float) -> void:
	knockback_velocity = knockback_velocity.move_toward(
		Vector2.ZERO,
		250 * delta
	)
	
func on_hurt(area: Area2D) -> void:
	knockback_velocity = area.owner.direction.normalized() * knockback_force
