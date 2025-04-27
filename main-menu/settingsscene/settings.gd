extends Control

func _on_audio_button_pressed() -> void:
	get_tree().change_scene_to_file("res://settingsscene/audio_settings.tscn")

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main-menu.tscn")
