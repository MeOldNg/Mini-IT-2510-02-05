extends Control

@onready var player: CharacterBody2D = $".."
var is_open = false

func _ready():
	close()
	
func _process(delta):
	if Input.is_action_just_pressed("esc"):
		if is_open:
			close()
		else:
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
