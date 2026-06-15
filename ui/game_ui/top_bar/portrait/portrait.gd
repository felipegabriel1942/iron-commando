extends Control
class_name Portrait

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func update_portrait(current: int, max_health: int) -> void:
	if current > 3:
		animated_sprite_2d.play("normal")
	else:
		animated_sprite_2d.play("near_death")
	
