extends CanvasLayer

func _process(_delta: float) -> void:
	match visible:
		true:
			if Input.is_action_just_pressed("key_esc"):
				visible = false
		false:
			if Input.is_action_just_pressed("key_esc"):
				visible = true


func _on_continue_btn_pressed() -> void:
	visible = false


func _on_restart_btn_pressed() -> void:
	get_tree().reload_current_scene.call_deferred()


func _on_exit_btn_pressed() -> void:
	get_tree().change_scene_to_file.call_deferred("res://Scenes/menu_inicio.tscn")
