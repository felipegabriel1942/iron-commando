extends Node

func play_sfx(sound: AudioStream, volume_db: float = 0.0) -> void:
	var player := AudioStreamPlayer.new()
	
	player.stream = sound
	player.bus = "SFX"
	player.volume_db = volume_db
	
	add_child(player)
	
	player.finished.connect(
		func(): player.queue_free()
	)
	
	player.play()
	
func play_random_sfx(
	sounds: Array[AudioStream],
	volume_db: float = 0.0
) -> void:
	if sounds.is_empty():
		return
		
	play_sfx(sounds.pick_random(), volume_db)
