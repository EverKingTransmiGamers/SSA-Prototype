class_name Editor_Camera extends Camera2D

var drag_pos: Vector2 = Vector2(10, 10)

# Control basico de la Cámara
func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		global_position.x = global_position.x - drag_pos.x
			
	if Input.is_action_pressed("ui_right"):
		global_position.x = global_position.x + drag_pos.x
			
	if Input.is_action_pressed("ui_up"):
		global_position.y = global_position.y - drag_pos.y
			
	if Input.is_action_pressed("ui_down"):
		global_position.y = global_position.y + drag_pos.y
			

func _on_exit_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu_inicio.tscn")
