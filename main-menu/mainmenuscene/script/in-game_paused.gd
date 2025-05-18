extends Control

func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://interstellar-apes/scenes/game.tscn")

func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main-menu/settingsscene/audio_settings.tscn")

func _on_character_button_pressed() -> void:
	pass # Replace with function body.

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main-menu/mainmenuscene/main-menu.tscn")
