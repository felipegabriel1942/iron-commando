extends Control
class_name AmmoDisplay

@onready var ammo_label: Label = $VBoxContainer/AmmoLabel

func setup(weapon: Weapon) -> void:
	var current_ammo = weapon.current_ammo 
	var reserve_ammo = weapon.reserve_ammo
	
	ammo_label.text = "%03d/%03d" % [current_ammo, reserve_ammo]

func update_ammo(current: int, reserve: int) -> void:
	ammo_label.text = "%03d/%03d" % [current, reserve]
