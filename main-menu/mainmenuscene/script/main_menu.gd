extends Control

func _on_play_game_button_pressed():
	get_tree().change_scene_to_file("res://main-menu/mainmenuscene/firstintro.tscn")

func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://main-menu/settingsscene/audio_settings.tscn")
	
func _on_quit_game_button_pressed():
	get_tree().quit()
	
