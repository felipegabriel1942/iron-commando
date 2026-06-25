extends Node2D
class_name Rocket

@onready var hitbox: HitboxComponent = $HitboxComponent

var speed := 400
var direction := Vector2.ZERO
var origin_cover := false
var current_trail: TrailEffect
var team := ""

const DUST_EFFECT = preload("uid://u6eukr6c4l47")
const EXPLOSION = preload("uid://b1e84cx2xxd4e")
const EXPLOSION_SFX = preload("uid://s6a6nfidacgn")

func _ready() -> void:
	if team == "player":
		hitbox.set_collision_layer_value(2, true)
		hitbox.set_collision_mask_value(1, true)
	else:
		hitbox.set_collision_layer_value(4, true)
		hitbox.set_collision_mask_value(3, true)
	
func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta
	# show_trail()

func _on_screen_exited() -> void:
	queue_free()

func _on_hitbox_area_exited(area: Area2D) -> void:
	if area.name.begins_with("CoverArea"):
		origin_cover = false
		
func show_trail() -> void:
	current_trail = TrailEffect.create_trail()
	add_child(current_trail)

func destroy() -> void:
	var explosion = EXPLOSION.instantiate() as Explosion
	explosion.global_position = global_position
	explosion.damage_data = hitbox.damage_data
	
	get_tree().current_scene.add_child(explosion)
	
	if team == "player":
		explosion.area_2d.set_collision_layer_value(2, true)
		explosion.area_2d.set_collision_mask_value(1, true)
	else:
		explosion.area_2d.set_collision_layer_value(4, true)
		explosion.area_2d.set_collision_mask_value(3, true)
	
	SfxManager.play_sfx(EXPLOSION_SFX, 20)
	
	queue_free()

func _on_on_body_hit(body: Variant) -> void:
	match body.name:
		"Walls":
			destroy()
		"Objects":
			if !origin_cover and randf() < 0.5:
				destroy()

func _on_hurtbox_hit(hurtbox: Variant) -> void:
	destroy()
