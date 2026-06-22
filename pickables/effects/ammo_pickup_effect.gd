extends PickupEffect
class_name AmmoPickupEffect

func apply(player: Player) -> void:
	player.weapon.add_ammo()
