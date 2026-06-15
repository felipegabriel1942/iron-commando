extends Node2D
class_name Bullet

@onready var hitbox: HitboxComponent = $Hitbox

var speed := 800
var direction := Vector2.ZERO
var origin_cover := false
var current_trail: TrailEffect
var team := ""
var hit_sounds: Array[AudioStream] = [
	preload("uid://dk0k71u1fj16w"),
	preload("uid://ctf36bixua6g2"),
]

const DUST_EFFECT = preload("uid://u6eukr6c4l47")

func _ready() -> void:
	if team == "player":
		hitbox.set_collision_layer_value(2, true)
		hitbox.set_collision_mask_value(1, true)
	else:
		hitbox.set_collision_layer_value(4, true)
		hitbox.set_collision_mask_value(3, true)
	
func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta
	show_trail()

func _on_screen_exited() -> void:
	queue_free()

func _on_hitbox_body_entered(body: Node2D) -> void:
	match body.name:
		"Walls":
			VfxManager.generate_particle_effect(DUST_EFFECT, global_position, (-direction).angle())
			SfxManager.play_random_sfx(hit_sounds)
			queue_free()
		"Objects":
			if !origin_cover and randf() < 0.5:
				queue_free()

func _on_hitbox_area_exited(area: Area2D) -> void:
	if area.name.begins_with("CoverArea"):
		origin_cover = false
		
func show_trail() -> void:
	current_trail = TrailEffect.create_trail()
	add_child(current_trail)
