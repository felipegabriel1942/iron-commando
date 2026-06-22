extends Node2D
class_name Weapon

signal ammo_changed(current, reserve)

@export var data: WeaponData
@export var cover_area: CoverAreaComponent
@export var burst_shoot := true
@export var burst_shoot_qtd := 3

@onready var muzzle: Marker2D = $Muzzle
@onready var shot_sound: AudioStreamPlayer2D = $ShotSound
@onready var reload_sound: AudioStreamPlayer2D = $ReloadSound

var can_shoot := true
var is_on_cover := false
var is_reloading := false

var current_ammo: int
var reserve_ammo: int

func _ready() -> void:
	shot_sound.stream = data.shot_sound
	reload_sound.stream = data.reload_sound
	
	current_ammo = data.magazine_size
	reserve_ammo = data.reserve_ammo
	
	cover_area.entered_cover_area.connect(on_cover_entered)
	cover_area.exited_cover_area.connect(on_cover_exited)

func _process(delta: float) -> void:
	if data.muzzle_positions.has(get_parent().facing_direction):
		muzzle.position = data.muzzle_positions[get_parent().facing_direction]

func shoot(direction) -> void:
	if not can_shoot:
		return
		
	if is_reloading:
		return
		
	if current_ammo <= 0:
		return
		
	can_shoot = false
	
	if burst_shoot:
		for i in range(burst_shoot_qtd):
			
			if current_ammo <= 0:
				break
			
			current_ammo -= 1
			
			shot_sound.play()
			create_bullet(direction)
			
			if i < burst_shoot_qtd - 1:
				await get_tree().create_timer(0.15).timeout
	else:
		current_ammo -= 1
		shot_sound.play()
		create_bullet(direction)
	
	ammo_changed.emit(current_ammo, reserve_ammo)
	
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
	
	projectile.hitbox.damage_data = DamageData.new(
		1,
		70,
		projectile.direction,
		owner
	)
	
func start_fire_rate_cooldown() -> void:
	await get_parent().get_tree().create_timer(data.fire_rate).timeout
	can_shoot = true

func on_cover_entered() -> void:
	is_on_cover = true

func on_cover_exited() -> void:
	is_on_cover = false

func reload() -> void:
	if is_reloading:
		return
	
	if current_ammo >= data.magazine_size:
		return
	
	if reserve_ammo <= 0:
		return
	
	is_reloading = true
	
	reload_sound.play()
	
	await get_tree().create_timer(data.reload_time).timeout
	
	var needed = data.magazine_size - current_ammo
	var amount = min(needed, reserve_ammo)
	
	current_ammo += amount
	reserve_ammo -= amount
	
	ammo_changed.emit(current_ammo, reserve_ammo)

	is_reloading = false

func add_ammo() -> void:
	reserve_ammo += data.pickup_ammount
	
	if reserve_ammo > data.max_reserve_ammo:
		reserve_ammo = data.max_reserve_ammo
		
	ammo_changed.emit(current_ammo, reserve_ammo)
