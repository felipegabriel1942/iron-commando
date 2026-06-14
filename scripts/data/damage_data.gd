class_name DamageData

var damage: int
var knockback_force: float
var direction: Vector2
var source: Node
var position: Vector2

func _init(
	damage: int,
	knockback_force: float,
	direction: Vector2,
	source: Node = null
):
	self.damage = damage
	self.knockback_force = knockback_force
	self.direction = direction
	self.source = source
