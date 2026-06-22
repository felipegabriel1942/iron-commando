extends CanvasLayer
class_name GameUI

@onready var healthbar: Healthbar = $TopHud/MarginContainer/HBoxContainer/Healthbar
@onready var portrait: Portrait = $TopHud/MarginContainer/HBoxContainer/Portrait
@onready var equipped_weapon: EquippedWeapon = $TopHud/MarginContainer/HBoxContainer/EquippedWeapon
@onready var ammo_display: AmmoDisplay = $TopHud/MarginContainer/HBoxContainer/AmmoDisplay
@onready var crosshair: Sprite2D = $Crosshair

var player: Player

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	player = get_tree().get_first_node_in_group("player")
	
	player.health_component.health_changed.connect(
		healthbar.update_health
	)
	
	player.health_component.health_changed.connect(
		portrait.update_portrait
	)
	
	player.weapon.ammo_changed.connect(
		ammo_display.update_ammo
	)
	
	healthbar.setup(player.health_component.max_health)
	equipped_weapon.setup(player.weapon.data)
	ammo_display.setup(player.weapon)

func _process(delta: float) -> void:
	crosshair.global_position = crosshair.get_global_mouse_position()
	
