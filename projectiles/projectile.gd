extends Area2D
class_name Projectile

var direction := Vector2.ZERO
var speed := 1000.0
var origin_cover := false

var current_trail: TrailEffect

const DUST_EFFECT = preload("uid://u6eukr6c4l47")

var hit_sounds: Array[AudioStream] = [
	preload("uid://dk0k71u1fj16w"),
	preload("uid://ctf36bixua6g2"),
]

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta
	show_trail()
	
func _on_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	match body.name:
		"Walls":
			VfxManager.generate_particle_effect(DUST_EFFECT, global_position, (-direction).angle())
			SfxManager.play_random_sfx(hit_sounds)
			queue_free()
		"Objects":
			if !origin_cover and randf() < 0.5:
				queue_free()

func _on_area_exited(area: Area2D) -> void:
	if area.name.begins_with("CoverArea"):
		origin_cover = false

func show_trail() -> void:
	current_trail = TrailEffect.create_trail()
	add_child(current_trail)
