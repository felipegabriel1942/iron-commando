extends Node2D
class_name PathfindComponent

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var timer: Timer = $Timer

var player: Player

func _ready() -> void:
	call_deferred("get_player")

func get_player() -> void:
	player = get_tree().get_first_node_in_group("player")

func _on_timer_timeout() -> void:
	if player:
		nav_agent.target_position = player.global_position
