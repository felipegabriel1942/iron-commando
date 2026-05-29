extends CharacterBody2D
class_name Player

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var weapon_muzzle: Marker2D = $WeaponMuzzle

var facing_direction := "down"
var move_speed := 60
var current_animation := ""
var equipped_weapon: Weapon

func _ready() -> void:
	add_to_group("player")
	equipped_weapon = AssaultRifle.new()
	
func _process(delta: float) -> void:
	handle_shoot()
	
func _physics_process(delta: float) -> void:
	handle_movement()
	update_facing_direction()
	update_muzzle_position()
	
	move_and_slide()
	
func handle_shoot() -> void:
	if Input.is_action_pressed("shoot"):
		var direction := (get_global_mouse_position() - global_position).normalized()
		
		equipped_weapon.try_shoot(self, direction)

func handle_movement() -> void:
	var direction := Vector2.ZERO

	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		
	velocity = direction * move_speed

func update_facing_direction() -> void:
	var mouse_direction := (get_global_mouse_position() - global_position).normalized()
	facing_direction = DirectionUtils.get_facing_direction(mouse_direction)

func update_muzzle_position() -> void:
	weapon_muzzle.position = equipped_weapon.get_muzzle_position(facing_direction)

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area is Projectile:
		flash_sprite()
		area.queue_free()

func flash_sprite() -> void:
	animated_sprite.material.set_shader_parameter("active", true)
	
	await get_tree().create_timer(0.1).timeout

	animated_sprite.material.set_shader_parameter("active", false)
