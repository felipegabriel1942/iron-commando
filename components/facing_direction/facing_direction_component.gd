extends Node2D
class_name FacingDirectionComponent

var facing: FacingDirection.Direction = FacingDirection.Direction.RIGHT

func face(target: Vector2) -> void:
	var angle := rad_to_deg(target.angle())
	
	if angle < 0:
		angle += 360
	if angle >= 337.5 or angle < 22.5:
		facing = FacingDirection.Direction.RIGHT
		#facing_direction = "right"
	elif angle >= 22.5 and angle < 67.5:
		facing = FacingDirection.Direction.DOWN_RIGHT
		#facing_direction = "down_right"
	elif angle >= 67.5 and angle < 112.5:
		facing = FacingDirection.Direction.DOWN
		#facing_direction = "down"
	elif angle >= 112.5 and angle < 157.5:
		facing = FacingDirection.Direction.DOWN_LEFT
		#facing_direction = "down_left"
	elif angle >= 157.5 and angle < 202.5:
		facing = FacingDirection.Direction.LEFT
		#facing_direction = "left"
	elif angle >= 202.5 and angle < 247.5:
		facing = FacingDirection.Direction.UP_LEFT
		#facing_direction = "up_left"
	elif angle >= 247.5 and angle < 292.5:
		facing = FacingDirection.Direction.UP
		#facing_direction = "up"
	else:
		facing = FacingDirection.Direction.UP_RIGHT
		#facing_direction = "up_right"
