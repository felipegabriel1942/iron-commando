extends Area2D
class_name PickableComponent

signal picked_up(player)

@export var effect: PickupEffect

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _process(delta: float) -> void:
	get_parent().get_node("Sprite2D").position.y += sin(Time.get_ticks_msec() * 0.005) * 0.2

func _on_body_entered(body) -> void:
	if body is Player:
		effect.apply(body)
		get_parent().queue_free()
		picked_up.emit(body)
