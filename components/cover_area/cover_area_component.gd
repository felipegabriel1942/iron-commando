extends Area2D
class_name CoverAreaComponent

signal entered_cover_area()
signal exited_cover_area()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Objects":
		entered_cover_area.emit()


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Objects":
		exited_cover_area.emit()
