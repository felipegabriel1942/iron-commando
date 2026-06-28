extends CharacterBody2D
class_name EnemyInfantry

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var weapon: Weapon = $Weapon
@onready var shoot_timer: Timer = $ShootTimer
@onready var knockback_component: KnockbackComponent = $KnockbackComponent
@onready var attack_range_component: AttackRangeComponent = $AttackRangeComponent
@onready var pathfind_component: PathfindComponent = $PathfindComponent
@onready var facing_direction: FacingDirectionComponent = $FacingDirectionComponent

#var facing_direction := "down"
var player: Player
var is_on_screen := false
var movement_velocity := Vector2.ZERO
var can_see := false
var show_debug_ray := false
var debug_target: Vector2
var debug_rays := []

const BLOOD_EFFECT = preload("uid://durt75xua78hy")
const BULLET_IMPACT = preload("uid://bxcwqg2m8yxib")

func _ready() -> void:
	add_to_group("enemy")
	
func _draw() -> void:
	for ray in debug_rays:
		if show_debug_ray:
			var color := Color.GREEN if ray["clear"] else Color.RED

			draw_line(
				to_local(ray["from"]),
				to_local(ray["to"]),
				color,
				2.0
			)
	
func _process(delta: float) -> void:
	can_see = can_see_player()
	
	queue_redraw()

func can_see_player() -> bool:
	if !is_on_screen:
		return false
		
	var offsets = [
		Vector2.ZERO,
		Vector2(8, 0),
		Vector2(-8, 0),
		Vector2(0, 8),
		Vector2(0, -8)
	]
	
	debug_rays.clear()
	
	for offset in offsets:
		var target = player.global_position + offset
		var hit = has_los(target)
		
		debug_rays.append({
			"from": global_position,
			"to": target,
			"clear": hit
		})
		
		if hit:
			queue_redraw()
			return true

	queue_redraw()
	return false

func has_los(target_pos: Vector2) -> bool:
	var query = PhysicsRayQueryParameters2D.create(
		global_position,
		target_pos
	)
	
	query.exclude = [self]
	query.collision_mask = (1 << 5)
	
	var result = get_world_2d().direct_space_state.intersect_ray(query)

	return result.is_empty()
	
func _physics_process(delta: float) -> void:
	update_facing_direction()
	
	velocity = Vector2.ZERO
	
	if knockback_component.knockback_velocity.length() > 0:
		velocity += knockback_component.knockback_velocity
	elif is_on_screen and !attack_range_component.on_range:
		var next_pos = pathfind_component.nav_agent.get_next_path_position()
		
		if global_position.distance_to(next_pos) > 2:
			velocity = global_position.direction_to(next_pos) * 40.0
		
	move_and_slide()

func update_facing_direction() -> void:
	player = get_tree().get_first_node_in_group("player")
	
	if player == null:
		return
	
	var direction := (player.global_position - global_position).normalized()
	facing_direction.face(direction)
	#facing_direction = DirectionUtils.get_facing_direction(direction)
	
func _on_shoot_timer_timeout() -> void:
	player = get_tree().get_first_node_in_group("player")
	
	if player == null or !is_on_screen or !can_see:
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
