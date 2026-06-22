extends Resource
class_name PickupEffect

func apply(player: Player) -> void:
	player.add_ammo()
