extends CharacterBody2D
class_name EnemyInfantry

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var weapon: Weapon = $Weapon
@onready var shoot_timer: Timer = $ShootTimer
@onready var knockback_component: KnockbackComponent = $KnockbackComponent

var facing_direction := "down"
var player: Player
var is_on_screen := false
var movement_velocity := Vector2.ZERO

const BLOOD_EFFECT = preload("uid://durt75xua78hy")
const BULLET_IMPACT = preload("uid://bxcwqg2m8yxib")

func _ready() -> void:
	add_to_group("enemy")

func _physics_process(delta: float) -> void:
	update_facing_direction()
	
	if knockback_component:
		velocity = movement_velocity
		velocity += knockback_component.knockback_velocity
	
	move_and_slide()

func update_facing_direction() -> void:
	player = get_tree().get_first_node_in_group("player")
	
	if player == null:
		return
	
	var direction := (player.global_position - global_position).normalized()
	facing_direction = DirectionUtils.get_facing_direction(direction)
	
func _on_shoot_timer_timeout() -> void:
	player = get_tree().get_first_node_in_group("player")
	
	if player == null or !is_on_screen:
		return
		
	var direction := (player.global_position - global_position).normalized()
	
	weapon.shoot(direction)

func _on_screen_entered() -> void:
	is_on_screen = true

func _on_died() -> void:
	queue_free()

func _on_damaged(damage_data: Variant) -> void:
	VfxManager.generate_particle_effect(BLOOD_EFFECT, damage_data.position, damage_data.direction.angle())
	SfxManager.play_sfx(BULLET_IMPACT)
	GameFeelManager.hit_stop(1)
	GameFeelManager.flash_shader(animated_sprite)
