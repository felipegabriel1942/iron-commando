extends CharacterBody2D
class_name Player

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var weapon_muzzle: Marker2D = $WeaponMuzzle

var facing_direction := "down"
var move_speed := 60
var current_animation := ""
var equipped_weapon: Weapon

func _ready() -> void:
	equipped_weapon = AssaultRifle.new()
	
func _process(delta: float) -> void:
	handle_shoot()
	
func _physics_process(delta: float) -> void:
	handle_movement()
	update_facing_direction()
	update_muzzle_position()
	handle_animation()
	
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
	var angle := rad_to_deg(mouse_direction.angle())
	
	if angle < 0:
		angle += 360
	if angle >= 337.5 or angle < 22.5:
		facing_direction = "right"
	elif angle >= 22.5 and angle < 67.5:
		facing_direction = "down_right"
	elif angle >= 67.5 and angle < 112.5:
		facing_direction = "down"
	elif angle >= 112.5 and angle < 157.5:
		facing_direction = "down_left"
	elif angle >= 157.5 and angle < 202.5:
		facing_direction = "left"
	elif angle >= 202.5 and angle < 247.5:
		facing_direction = "up_left"
	elif angle >= 247.5 and angle < 292.5:
		facing_direction = "up"
	else:
		facing_direction = "up_right"
		
func update_muzzle_position() -> void:
	weapon_muzzle.position = equipped_weapon.get_muzzle_position(facing_direction)

func handle_animation() -> void:
	var animation_prefix := "idle_"
	
	if velocity.length() > 0:
		animation_prefix = "move_"
		
	var direction := get_animation_direction()
	
	play_animation(animation_prefix + direction + "_" + equipped_weapon.data.animation_suffix)
	
func get_animation_direction() -> String:
	animated_sprite.flip_h = false
	
	match facing_direction:
		"right":
			return "side"
		"left":
			animated_sprite.flip_h = true
			return "side"
		"up":
			return "up"
		"down":
			return "down"
		"up_left":
			animated_sprite.flip_h = true
			return "diagonal_up"
		"up_right":
			return "diagonal_up"
		"down_left":
			animated_sprite.flip_h = true
			return "diagonal_down"
		"down_right":
			return "diagonal_down"

	return "down"

func play_animation(animation_name: String) -> void:
	if current_animation == animation_name:
		return

	current_animation = animation_name
	animated_sprite.play(current_animation)
