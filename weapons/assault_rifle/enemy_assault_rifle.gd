extends Weapon
class_name EnemyAssaultRifle

func _init() -> void:
	data = preload(
		"res://resources/weapons/enemy_assault_rifle.tres"
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

func shoot(owner, direction) -> void:
	var projectile = data.projectile.instantiate()
	var angle = direction.angle()
	var recoil = deg_to_rad(randi_range(-10, 10))
	
	projectile.global_position = owner.weapon_muzzle.global_position
	projectile.direction = direction.rotated(recoil)
	projectile.rotation = angle
	
	owner.get_tree().current_scene.add_child(projectile)
