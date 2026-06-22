extends Node2D
class_name BaseLevel

@onready var pickables: Node2D = $YSortRoot/Pickables

func _ready() -> void:
	pickables.add_to_group("pickables")
