extends Node2D
class_name AnimationComponent

@export var facing_direction: FacingDirectionComponent

var current_animation := ""

func _physics_process(delta: float) -> void:
	handle_animation()

func handle_animation() -> void:
	var animation_prefix := "idle_"
	
	if get_parent().velocity.length() > 0:
		animation_prefix = "move_"
		
	var direction := get_animation_direction()
	
	play_animation(animation_prefix + direction + "_" + get_parent().weapon.data.animation_suffix)
	
func play_animation(animation_name: String) -> void:
	if current_animation == animation_name:
		return

	current_animation = animation_name
	get_parent().animated_sprite.play(current_animation)

func get_animation_direction() -> String:
	get_parent().animated_sprite.flip_h = false
	
	match facing_direction.facing:
		FacingDirection.Direction.RIGHT:
			return "side"
		FacingDirection.Direction.LEFT:
			get_parent().animated_sprite.flip_h = true
			return "side"
		FacingDirection.Direction.UP:
			return "up"
		FacingDirection.Direction.DOWN:
			return "down"
		FacingDirection.Direction.UP_LEFT:
			get_parent().animated_sprite.flip_h = true
			return "diagonal_up"
		FacingDirection.Direction.UP_RIGHT:
			return "diagonal_up"
		FacingDirection.Direction.DOWN_LEFT:
			get_parent().animated_sprite.flip_h = true
			return "diagonal_down"
		FacingDirection.Direction.DOWN_RIGHT:
			return "diagonal_down"

	return "down"
