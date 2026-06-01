extends Area2D
class_name Projectile

var direction := Vector2.ZERO
var speed := 500.0
var origin_cover := false

func _ready() -> void:
	check_initial_collisions()

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

func _on_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	match body.name:
		"Walls":
			queue_free()

func check_initial_collisions() -> void:
	await get_tree().physics_frame
	await get_tree().physics_frame
	
	for area in get_overlapping_areas():
		_handle_area_collision(area)
		
func _handle_area_collision(area: Area2D) -> void:
	if is_instance_valid(area):
		if area.name == "CoverArea" or area.name == "HurtboxComponent":
			origin_cover = true
