extends Control

func _enter_tree():
	self.visible = false

func _unhandled_input(event : InputEvent) -> void:
	if event.is_action_released("option"):
		toggle_pause()

func toggle_pause() -> void:
	visible = !visible


func _on_continue_pressed() -> void:
	toggle_pause()

func _on_exit_pressed() -> void:
	get_tree().quit()
