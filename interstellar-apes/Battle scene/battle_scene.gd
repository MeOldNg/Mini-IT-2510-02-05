extends Node2D

@onready var defend_effect = $CharacterBody2D/AnimatedSprite2D

signal textbox_closed
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextBox.hide()
	$CanvasLayer/choice.hide()
	
	display_text("level one begins!!!")
	await self.textbox_closed
	$CanvasLayer/choice.show()



func _input(event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		$TextBox.hide()
		emit_signal("textbox_closed")
	

func display_text(text):
	$TextBox.show()
	$TextBox/Label.text = text

func _on_abort_pressed() -> void:
	display_text("The player escape the battle....")
	await self.textbox_closed
	get_tree().quit()
