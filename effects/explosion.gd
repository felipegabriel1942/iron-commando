extends Node2D
class_name Explosion

@onready var area_2d: Area2D = $Area2D

var damage_data: DamageData

func _on_animation_finished() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	print(body)

func _on_area_entered(area: Area2D) -> void:
	for hurtbox in area_2d.get_overlapping_areas():
		if hurtbox:
			(hurtbox as HurtboxComponent).receive_hit(damage_data)
