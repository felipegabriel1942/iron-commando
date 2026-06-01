extends Node2D
class_name BaseLevel

@onready var player: Player = $YSortRoot/Player
@onready var map_layers: Node2D = $YSortRoot/MapLayers

func _ready() -> void:
	adjust_camera_limits()

func adjust_camera_limits() -> void:
	var ground_layer := map_layers.get_children().get(0) as TileMapLayer
	var used_rect := ground_layer.get_used_rect()
	var tile_size := ground_layer.tile_set.tile_size
	var size := Vector2(used_rect.size * tile_size)
	var position := ground_layer.to_global(Vector2(used_rect.position * tile_size))
	
	player.camera.limit_left = int(position.x)
	player.camera.limit_top = int(position.y)
	player.camera.limit_right = int(position.x + size.x)
	player.camera.limit_bottom = int(position.y + size.y)
