extends Node2D
class_name Weapon

@export var data: WeaponData
@export var cover_area: CoverAreaComponent
@export var burst_shoot := true
@export var burst_shoot_qtd := 3

@onready var muzzle: Marker2D = $Muzzle
@onready var audio_stream: AudioStreamPlayer2D = $AudioStreamPlayer2D

var can_shoot := true
var is_on_cover := false

func _ready() -> void:
	audio_stream.stream = data.shot_sound
	
	cover_area.entered_cover_area.connect(on_cover_entered)
	cover_area.exited_cover_area.connect(on_cover_exited)

func _process(delta: float) -> void:
	if data.muzzle_positions.has(get_parent().facing_direction):
		muzzle.position = data.muzzle_positions[get_parent().facing_direction]

func shoot(direction) -> void:
	if not can_shoot:
		return
		
	can_shoot = false
	
	if burst_shoot:
		for i in range(burst_shoot_qtd):
			await get_tree().create_timer(0.15).timeout
			audio_stream.play()
			create_bullet(direction)
	else:
		audio_stream.play()
		create_bullet(direction)
	
	start_fire_rate_cooldown()

func create_bullet(direction) -> void:
	var projectile = data.projectile.instantiate()
	var angle = direction.angle()
	var recoil = deg_to_rad(randi_range(data.recoil_range * -1, data.recoil_range))
	
	projectile.global_position = muzzle.global_position
	projectile.direction = direction.rotated(recoil)
	projectile.rotation = angle
	projectile.origin_cover = is_on_cover
	projectile.team = get_parent().get_groups()[0]
	
	get_tree().current_scene.add_child(projectile)

func start_fire_rate_cooldown() -> void:
	await get_parent().get_tree().create_timer(data.fire_rate).timeout
	can_shoot = true

func on_cover_entered() -> void:
	is_on_cover = true

func on_cover_exited() -> void:
	is_on_cover = false
