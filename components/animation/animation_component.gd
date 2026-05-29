extends Node2D
class_name AnimationComponent

var current_animation := ""

func _physics_process(delta: float) -> void:
	handle_animation()

func handle_animation() -> void:
	var animation_prefix := "idle_"
	
	if get_parent().velocity.length() > 0:
		animation_prefix = "move_"
		
	var direction := get_animation_direction()
	
	play_animation(animation_prefix + direction + "_" + get_parent().equipped_weapon.data.animation_suffix)
	
func play_animation(animation_name: String) -> void:
	if current_animation == animation_name:
		return

	current_animation = animation_name
	get_parent().animated_sprite.play(current_animation)

func get_animation_direction() -> String:
	get_parent().animated_sprite.flip_h = false
	
	match get_parent().facing_direction:
		"right":
			return "side"
		"left":
			get_parent().animated_sprite.flip_h = true
			return "side"
		"up":
			return "up"
		"down":
			return "down"
		"up_left":
			get_parent().animated_sprite.flip_h = true
			return "diagonal_up"
		"up_right":
			return "diagonal_up"
		"down_left":
			get_parent().animated_sprite.flip_h = true
			return "diagonal_down"
		"down_right":
			return "diagonal_down"

	return "down"
