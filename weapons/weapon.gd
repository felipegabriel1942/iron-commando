extends Node2D
class_name Weapon

@export var data: WeaponData

@onready var muzzle: Marker2D = $Muzzle
@onready var audio_stream: AudioStreamPlayer2D = $AudioStreamPlayer2D

var can_shoot := true

func _ready() -> void:
	audio_stream.stream = data.shot_sound

func _process(delta: float) -> void:
	if data.muzzle_positions.has(get_parent().facing_direction):
		muzzle.position = data.muzzle_positions[get_parent().facing_direction]

func shoot(direction) -> void:
	if not can_shoot:
		return
		
	can_shoot = false

	audio_stream.play()
	
	var projectile = data.projectile.instantiate()
	var angle = direction.angle()
	var recoil = deg_to_rad(randi_range(data.recoil_range * -1, data.recoil_range))
	
	projectile.global_position = muzzle.global_position
	projectile.direction = direction.rotated(recoil)
	projectile.rotation = angle
	
	get_tree().current_scene.add_child(projectile)
	
	start_fire_rate_cooldown()

func start_fire_rate_cooldown() -> void:
	await get_parent().get_tree().create_timer(data.fire_rate).timeout
	can_shoot = true
