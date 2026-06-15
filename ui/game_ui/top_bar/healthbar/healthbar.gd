extends Control
class_name Healthbar

@onready var hbox: HBoxContainer = $HBoxContainer/PanelContainer/MarginContainer/HBoxContainer

var blocks: Array = []
var max_health: int
var current_health: int

const HEALTH_FULL = preload("uid://dmcesr1t7e5n2")

func setup(max_health: int) -> void:
	self.max_health = max_health
	current_health = max_health
	
	for block in hbox.get_children():
		block.queue_free()
		
	for i in range(max_health):
		var block := TextureRect.new()
		block.texture = HEALTH_FULL
		block.stretch_mode = TextureRect.STRETCH_KEEP
		
		hbox.add_child(block)
		blocks.append(block)

func update_health(current: int, max_health: int) -> void:
	current_health = clamp(current, 0, max_health)
	
	for i in range(blocks.size()):
		if i >= current_health:
			blocks[i].visible = false
		else:
			blocks[i].visible = true
