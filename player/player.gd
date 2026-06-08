extends CharacterBody2D
class_name Player

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera: Camera2D = $Camera2D
@onready var weapon: Weapon = $Weapon
@onready var knockback_component: KnockbackComponent = $KnockbackComponent

var facing_direction := "down"
var move_speed := 60
var current_animation := ""
var hits := 0
var movement_velocity := Vector2.ZERO

func _ready() -> void:
	add_to_group("player")
	
func _process(delta: float) -> void:
	handle_shoot()
	
func _physics_process(delta: float) -> void:
	handle_movement()
	update_facing_direction()
	
	velocity = (
		movement_velocity + knockback_component.knockback_velocity
	)

	move_and_slide()
	
func handle_shoot() -> void:
	if Input.is_action_pressed("shoot"):
		var direction := (get_global_mouse_position() - global_position).normalized()
		
		weapon.shoot(direction)

func handle_movement() -> void:
	var direction := Vector2.ZERO

	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	
	movement_velocity = direction * move_speed

func update_facing_direction() -> void:
	var mouse_direction := (get_global_mouse_position() - global_position).normalized()
	facing_direction = DirectionUtils.get_facing_direction(mouse_direction)

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area is Projectile:
		GameFeelManager.flash_shader(animated_sprite)
		GameFeelManager.shake_camera()
		
		area.queue_free()
