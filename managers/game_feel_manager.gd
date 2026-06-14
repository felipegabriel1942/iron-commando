extends Node

var is_hit_stopping := false
var camera: Camera2D

func hit_stop(frames: int = 8, time_scale: float = 0.05) -> void:
	if is_hit_stopping:
		return
		
	is_hit_stopping = true
	
	Engine.time_scale = time_scale
	
	for i in frames:
		await get_tree().process_frame
	
	Engine.time_scale = 1.0
	
	is_hit_stopping = false

func flash_shader(
	node: CanvasItem,
	parameter_name: String = "active",
	times: int = 2,
	duration: float = 0.1
) -> void:
	if node == null:
		return
	
	if node.material == null:
		return
		
	for i in times:
		if is_instance_valid(node):
			node.material.set_shader_parameter(parameter_name, true)
			
			await get_tree().create_timer(duration).timeout
			
			if !is_instance_valid(node):
				return
				
			node.material.set_shader_parameter(parameter_name, false)
			
			await get_tree().create_timer(duration).timeout


func shake_camera(intensity := 5.0) -> void:
	var original_offset = camera.offset
	
	camera.offset += Vector2(
		randf_range(-intensity, intensity),
		randf_range(-intensity, intensity)
	)

	var tween = camera.create_tween()
	
	tween.tween_property(
		camera,
		"offset",
		original_offset,
		0.08
	)
