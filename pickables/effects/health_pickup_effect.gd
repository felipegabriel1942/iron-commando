extends PickupEffect
class_name HealthPickupEffect

@export var amount := 2

func apply(player: Player):
	player.health_component.heal(amount)
