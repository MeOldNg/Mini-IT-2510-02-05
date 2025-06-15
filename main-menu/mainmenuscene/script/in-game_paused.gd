extends Control

@onready var player: CharacterBody2D = $".."
var is_open = false

func _ready():
	close()
	
func _process(delta):
	if Input.is_action_just_pressed("esc"):
		if is_open:
			var file = FileAccess.open("res://savegame.dat",FileAccess.WRITE)
			file.store_var(player.global_position)
			file.close()
			close()
		else:
			var file = FileAccess.open("res://savegame.dat",FileAccess.READ)
			player.global_position = file.get_var()
			file.close()
			open()
	
func open():
	self.visible = true
	is_open = true
	
func close():
	visible = false
	is_open = false

func _on_continue_button_pressed() -> void:
	close()

func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main-menu/settingsscene/in-game_audio.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main-menu/mainmenuscene/main-menu.tscn")
