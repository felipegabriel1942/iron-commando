extends Control
class_name EquippedWeapon

@onready var label: Label = $VBoxContainer/Label
@onready var texture_rect: TextureRect = $VBoxContainer/TextureRect

func setup(weapon_data: WeaponData) -> void:
	label.text = weapon_data.short_name
	texture_rect.texture = weapon_data.weapon_icon
