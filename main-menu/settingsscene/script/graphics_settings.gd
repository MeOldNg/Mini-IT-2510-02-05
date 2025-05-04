extends Control

func _on_audio_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main-menu/settingsscene/audio_settings.tscn")

func _on_graphics_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main-menu/settingsscene/graphics_settings.tscn")

func _on_ingame_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main-menu/settingsscene/ingame_settings.tscn")

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main-menu/mainmenuscene/main-menu.tscn")
