extends Camera2D

const MAX_DISTANCE = 64

var target_distance = 0
var center_pos = position
var ground_layer: TileMapLayer

func _ready() -> void:
	ground_layer = get_tree().current_scene.get_node("%Ground")
	
	adjust_camera_limits()

func _process(delta: float) -> void:
	handle_camera_movement()
	
func handle_camera_movement() -> void:
	var direction = center_pos.direction_to(get_local_mouse_position())
	var target_pos = center_pos + direction * target_distance
	
	target_pos = target_pos.clamp(
		center_pos - Vector2(MAX_DISTANCE, MAX_DISTANCE),
		center_pos + Vector2(MAX_DISTANCE, MAX_DISTANCE)
	)
	
	position = target_pos
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		target_distance = center_pos.distance_to(get_local_mouse_position()) / 2

func adjust_camera_limits() -> void:
	if ground_layer != null:
		var used_rect := ground_layer.get_used_rect()
		var tile_size := ground_layer.tile_set.tile_size
		var size := Vector2(used_rect.size * tile_size)
		var position := ground_layer.to_global(Vector2(used_rect.position * tile_size))
		
		limit_left = int(position.x)
		limit_top = int(position.y)
		limit_right = int(position.x + size.x)
		limit_bottom = int(position.y + size.y)
