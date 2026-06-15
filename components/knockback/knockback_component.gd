extends Node2D
class_name KnockbackComponent

var knockback_velocity := Vector2.ZERO

func apply_knockback(direction: Vector2, force: float) -> void:
	knockback_velocity = direction.normalized() * force

func _physics_process(delta: float) -> void:
	knockback_velocity = knockback_velocity.move_toward(
		Vector2.ZERO,
		250 * delta
	)
