extends Control

func _on_audio_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main-menu/settingsscene/audio_settings.tscn")

func _on_graphics_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main-menu/settingsscene/graphics_settings.tscn")

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main-menu/mainmenuscene/main-menu.tscn")
	
func _on_fullscreen_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
