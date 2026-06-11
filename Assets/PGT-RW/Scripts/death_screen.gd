extends Control


func _on_retry_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main_Components/level_scene_manager.tscn")

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu_inicio.tscn")
