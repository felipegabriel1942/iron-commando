extends Node2D
class_name LootDropComponent

@export var health_component: HealthComponent
@export var health_pickup_scene: PackedScene
@export var ammo_pickup_scene: PackedScene

func _ready() -> void:
	health_component.died.connect(drop_loot)

func drop_loot() -> void:
	var roll = randf()
	
	if roll < 0.2 and !health_component.is_full_health():
		spawn_pickup(health_pickup_scene)
		return
		
	if roll < 0.3:
		spawn_pickup(ammo_pickup_scene)
		return

func spawn_pickup(scene: PackedScene) -> void:
	var pickup = scene.instantiate()
	pickup.global_position = global_position
	get_tree().get_first_node_in_group("pickables").add_child(pickup)
