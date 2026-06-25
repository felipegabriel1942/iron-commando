extends Resource
class_name WeaponData

@export var weapon_name: String
@export var animation_suffix: String
@export var projectile: PackedScene
@export var fire_rate := 0.2
@export var shot_sound: AudioStreamMP3
@export var muzzle_positions: Dictionary[String, Vector2]
@export var recoil_range := 5
@export var magazine_size: int = 12
@export var reserve_ammo: int = 48
@export var reload_time: float = 1.5
@export var reload_sound:  AudioStreamMP3
@export var weapon_icon: Texture
@export var short_name: String
@export var pickup_ammount := 30
@export var max_reserve_ammo: int = 999
@export var damage: int = 1
@export var knockback_force: int = 70
@export var damage_type: DamageType.Type
