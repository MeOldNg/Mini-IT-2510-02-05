extends Control

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main-menu/mainmenuscene/main-menu.tscn")

func _on_master_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),linear_to_db(value))

func _on_music_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"),linear_to_db(value))

func _on_graphics_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main-menu/settingsscene/graphics_settings.tscn")

func _on_ingame_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main-menu/settingsscene/ingame_settings.tscn")
