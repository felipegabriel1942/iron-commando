extends CanvasLayer
class_name GameUI

@onready var healthbar: Healthbar = $TopHud/MarginContainer/HBoxContainer/Healthbar
@onready var portrait: Portrait = $TopHud/MarginContainer/HBoxContainer/Portrait

var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
	player.health_component.health_changed.connect(
		healthbar.update_health
	)
	
	player.health_component.health_changed.connect(
		portrait.update_portrait
	)
	
	healthbar.setup(player.health_component.max_health)
	
