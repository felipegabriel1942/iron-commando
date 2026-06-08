extends Node

func generate_particle_effect(
	effect_scene: PackedScene, 
	position: Vector2, 
	rotation: float = 0.0
) -> void:
	
	var effect = effect_scene.instantiate()
	effect.global_position = position
	effect.rotation = rotation
	effect.emitting = true
	effect.finished.connect(effect.queue_free)

	var vfx_container = get_tree().current_scene.get_node("%VFX")
	vfx_container.add_child(effect)
