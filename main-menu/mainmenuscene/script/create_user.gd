extends Panel

signal createUser(user, password)

func _on_submit_button_down() -> void:
	createUser.emit($VBoxContainer/UsernameContainer/UsernameEnter.text, $VBoxContainer/PasswordContainer/PasswordEnter.text)
	pass # Replace with function body.

func _on_return_button_down() -> void:
	queue_free()
	pass # Replace with function body.
