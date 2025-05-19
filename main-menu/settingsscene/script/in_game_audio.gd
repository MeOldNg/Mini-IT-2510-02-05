extends Control

func _on_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),linear_to_db(value))

func _on_fullscreen_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main-menu/mainmenuscene/in-game_paused.tscn")

func _on_mute_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		var bus_idx = AudioServer.get_bus_index("Master")
		AudioServer.set_bus_mute(bus_idx, true)
	else:
		var bus_idx = AudioServer.get_bus_index("Master")
		AudioServer.set_bus_mute(bus_idx, false)
