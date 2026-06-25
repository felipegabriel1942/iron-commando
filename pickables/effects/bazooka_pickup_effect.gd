extends PickupEffect
class_name BazookaPickupEffect

const BAZOOKA = preload("uid://51g4smambrco")

func apply(player: Player) -> void:
	player.weapon.equip_weapon(BAZOOKA)
