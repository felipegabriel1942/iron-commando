extends Line2D
class_name TrailEffect

const MAX_POINTS := 3000
@onready var trail := Curve2D.new()

func _process(delta: float) -> void:
	trail.add_point(get_parent().position)
	
	if trail.get_baked_points().size() > MAX_POINTS:
		trail.remove_point(0)
	
	points = trail.get_baked_points()
	
static func create_trail() -> TrailEffect:
	var trail_scene = preload("res://projectiles/trail_effect.tscn")
	return trail_scene.instantiate()
	
func _on_timer_timeout() -> void:
	set_process(false)
	var fade_tween = get_tree().create_tween()
	fade_tween.tween_property(self, "modulate:a", 0.0, 0.05)
	await fade_tween.finished
	queue_free()
