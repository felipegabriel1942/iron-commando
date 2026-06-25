extends PickupEffect
class_name AssaultRiflePickupEffect

const ASSAULT_RIFLE = preload("uid://blyrwphuvtkdn")

func apply(player: Player) -> void:
	player.weapon.equip_weapon(ASSAULT_RIFLE)
