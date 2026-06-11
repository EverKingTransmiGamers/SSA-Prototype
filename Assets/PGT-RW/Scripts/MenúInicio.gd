extends Control
"""
Para centrar los botones, titulos, contenedores, etc.
se tienen que agregar los botones hijo en nodos Controles hijo
de la principal escena.
"""

func _ready() -> void:
	RenderingServer.set_default_clear_color(Color("4d4d4d"))
		
func _start_button_pressed():
	var lvlscnmgr:PackedScene = load("uid://v5aai5fswitk")
	get_tree().change_scene_to_packed(lvlscnmgr)
		
func _on_editor_button_pressed() -> void:
	var editor_escena:PackedScene = load("uid://ba114kohu7slf")
	get_tree().change_scene_to_packed(editor_escena)
		
func _on_test_level_button_pressed() -> void:
	var test_world0:PackedScene = load("res://Scenes/test_world0.tscn")
	get_tree().change_scene_to_packed(test_world0)
		
func _exit_button_pressed():
	%ExitDialogCont.visible = true
		
func _exit_yes_button_up() -> void:
	get_tree().quit()
		
func _exit_no_button_up() -> void:
	%ExitDialogCont.visible = false
		
