extends CharacterBody2D
class_name Player

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera: Camera2D = $Camera2D
@onready var weapon: Weapon = $Weapon
@onready var knockback_component: KnockbackComponent = $KnockbackComponent
@onready var health_component: HealthComponent = $HealthComponent

var facing_direction := "down"
var move_speed := 60
var movement_velocity := Vector2.ZERO

func _ready() -> void:
	add_to_group("player")
	
func _process(delta: float) -> void:
	handle_shoot()
	handle_reload()
	
func _physics_process(delta: float) -> void:
	handle_movement()
	update_facing_direction()
	
	if knockback_component:
		velocity = movement_velocity
		velocity += knockback_component.knockback_velocity

	move_and_slide()
	
func handle_shoot() -> void:
	if Input.is_action_pressed("shoot"):
		var direction := (get_global_mouse_position() - global_position).normalized()
		
		weapon.shoot(direction)

func handle_reload() -> void:
	if Input.is_action_pressed("reload"):
		weapon.reload()

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

func _on_damaged(damage_data: Variant) -> void:
	GameFeelManager.flash_shader(animated_sprite)
	GameFeelManager.shake_camera()
