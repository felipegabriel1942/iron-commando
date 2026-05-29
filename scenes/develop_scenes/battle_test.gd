extends Node2D
class_name BattleTest

@onready var spawners_container: Node2D = $YSortRoot/SpawnersContainer
@onready var enemies_container: Node2D = $YSortRoot/EnemiesContainer

var spawner_points: Array[Marker2D] = []

const ENEMY_INFANTRY = preload("uid://bmyy7t6hkg4u")

func _ready() -> void:
	randomize()
	
	for spawner in spawners_container.get_children():
		if spawner is Marker2D:
			spawner_points.append(spawner)

func _on_spawn_time() -> void:
	if spawner_points.size() > enemies_container.get_children().size():
		spawn_enemy()
	else:
		print("maximum capacity")

func spawn_enemy() -> void:
	var enemy = ENEMY_INFANTRY.instantiate()	
	enemy.global_position = get_spawn_position()
	enemies_container.add_child(enemy)

func get_spawn_position() -> Vector2:
	var spawn_point_index = randi_range(0, spawner_points.size() - 1)
	var spawn_pos = spawner_points.get(spawn_point_index).global_position
	
	for enemy in enemies_container.get_children():
		if enemy is EnemyInfantry and enemy.global_position == spawn_pos:
			spawn_pos = get_spawn_position()
	
	return spawn_pos
