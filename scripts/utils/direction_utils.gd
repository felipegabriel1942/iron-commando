extends Node
class_name DirectionUtils

static func get_facing_direction(pos: Vector2) -> String:
	var facing_direction = ""
	
	var angle := rad_to_deg(pos.angle())
	
	if angle < 0:
		angle += 360
	if angle >= 337.5 or angle < 22.5:
		facing_direction = "right"
	elif angle >= 22.5 and angle < 67.5:
		facing_direction = "down_right"
	elif angle >= 67.5 and angle < 112.5:
		facing_direction = "down"
	elif angle >= 112.5 and angle < 157.5:
		facing_direction = "down_left"
	elif angle >= 157.5 and angle < 202.5:
		facing_direction = "left"
	elif angle >= 202.5 and angle < 247.5:
		facing_direction = "up_left"
	elif angle >= 247.5 and angle < 292.5:
		facing_direction = "up"
	else:
		facing_direction = "up_right"
		
	return facing_direction
