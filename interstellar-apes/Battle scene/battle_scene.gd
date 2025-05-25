extends Node2D

signal textbox_closed
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextBox.hide()
	
	display_text("monkey receive damages")
	await self.textbox_closed



func _input(event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		$TextBox.hide()
		emit_signal("textbox_closed")
	

func display_text(text):
	$TextBox.show()
	$TextBox/Label.text = text
