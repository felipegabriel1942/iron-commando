extends CharacterBody2D
class_name EnemyInfantry

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var weapon_muzzle: Marker2D = $WeaponMuzzle
@onready var weapon: Weapon = $Weapon
@onready var shoot_timer: Timer = $ShootTimer
@onready var knockback_component: KnockbackComponent = $KnockbackComponent

var facing_direction := "down"
var current_animation := ""
var player: Player
var invencibility := false
var hit_points :=5
var is_on_screen := false
var invencibility_time := 0.3
var movement_velocity := Vector2.ZERO

const BLOOD_EFFECT = preload("uid://durt75xua78hy")
const BULLET_IMPACT = preload("uid://bxcwqg2m8yxib")

func _ready() -> void:
	add_to_group("enemy")

func _physics_process(delta: float) -> void:
	update_facing_direction()
	
	velocity = (
		movement_velocity + knockback_component.knockback_velocity
	)
	
	move_and_slide()

func update_facing_direction() -> void:
	player = get_tree().get_first_node_in_group("player")
	
	if player == null:
		return
	
	var direction := (player.global_position - global_position).normalized()
	facing_direction = DirectionUtils.get_facing_direction(direction)
	
func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.owner is Bullet:
		take_damage(area.owner.position, area.owner.direction)
		area.owner.queue_free()
		
func take_damage(hit_position: Vector2, hit_direction: Vector2) -> void:
	if !invencibility and is_on_screen:
			
		hit_points -= 1
		
		VfxManager.generate_particle_effect(BLOOD_EFFECT, hit_position, hit_direction.angle())
		SfxManager.play_sfx(BULLET_IMPACT)
		GameFeelManager.hit_stop(1)
		GameFeelManager.flash_shader(animated_sprite)
		
		if hit_points <= 0:
			queue_free()
		
		invencibility = true
		
		await get_tree().create_timer(invencibility_time).timeout
		
		invencibility = false

func _on_shoot_timer_timeout() -> void:
	player = get_tree().get_first_node_in_group("player")
	
	if player == null or !is_on_screen:
		return
		
	var direction := (player.global_position - global_position).normalized()
	
	weapon.shoot(direction)

func _on_screen_entered() -> void:
	is_on_screen = true
