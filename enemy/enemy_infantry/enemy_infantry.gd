extends CharacterBody2D
class_name EnemyInfantry

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var weapon_muzzle: Marker2D = $WeaponMuzzle

var facing_direction := "down"
var current_animation := ""
var equipped_weapon: Weapon
var player: Player
var invencibility := false
var hit_points := 3

func _ready() -> void:
	equipped_weapon = EnemyAssaultRifle.new()
	
func _physics_process(delta: float) -> void:
	update_facing_direction()

func update_facing_direction() -> void:
	player = get_tree().get_first_node_in_group("player")
	
	if player == null:
		return
	
	var direction := (player.global_position - global_position).normalized()
	facing_direction = DirectionUtils.get_facing_direction(direction)
	
func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area is Projectile:
		take_damage()
		area.queue_free()
		
func take_damage() -> void:
	if !invencibility:
		
		flash_sprite()
		
		hit_points -= 1
		
		if hit_points <= 0:
			queue_free()
		
		invencibility = true
		
		await get_tree().create_timer(0.3).timeout
		
		invencibility = false

func flash_sprite() -> void:
	for i in range(2):
		animated_sprite.material.set_shader_parameter("active", true)
		await get_tree().create_timer(0.1).timeout
		animated_sprite.material.set_shader_parameter("active", false)
		await get_tree().create_timer(0.1).timeout

func _on_shoot_timer_timeout() -> void:
	player = get_tree().get_first_node_in_group("player")
	
	if player == null:
		return
		
	var direction := (player.global_position - global_position).normalized()
		
	equipped_weapon.try_shoot(self, direction)
