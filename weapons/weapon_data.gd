extends Resource
class_name WeaponData

@export var weapon_name: String
@export var animation_suffix: String
@export var projectile: PackedScene
@export var fire_rate := 0.2
@export var shot_sound: AudioStreamMP3
@export var muzzle_positions: Dictionary[String, Vector2]
@export var recoil_range := 5
