extends Weapon
class_name AssaultRifle

func _init() -> void:
	data = preload(
		"res://resources/weapons/assault_rifle.tres"
	)
	
func get_muzzle_position(facing_direction) -> Vector2:
	var positions = {
		"up": Vector2(5, -7),
		"up_right": Vector2(8, -7),
		"right": Vector2(8, -1),
		"down_right": Vector2(5, 9),
		"down": Vector2(-6, 10),
		"down_left": Vector2(-7, 9),
		"left": Vector2(-10, -1),
		"up_left": Vector2(-10, -7),
	}
	
	return positions[facing_direction]
