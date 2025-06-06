extends Control
"""
Para centrar los botones, titulos, contenedores, etc.
se tienen que agregar los botones hijo en nodos Controles hijo
de la principal escena.
"""

func _on_start_button_pressed():
	get_tree().change_scene_to_file.call_deferred("res://Scenes/mundo.tscn")

func _on_exit_button_pressed():
	get_tree().quit()


func _on_editor_button_pressed() -> void:
	get_tree().change_scene_to_file.call_deferred("res://Scenes/editor_proto.tscn")
