class_name EditorPauseGui extends CanvasLayer

@onready var editorProto1K:EditorProto1K = self.owner

@onready var saveQsnDlg:Control = %SaveDialogPanelCont

func _input(event:InputEvent) -> void:
	# Esto pausará el juego si paused es cierto, de lo contrario lo continuará.
	if event is InputEventKey:
		match get_tree().paused:
			true:
				self.visible = true
				if event.pressed and event.keycode == Key.KEY_ESCAPE:
					get_tree().paused = false
						
			false:
				self.visible = false
				if event.pressed and event.keycode == Key.KEY_ESCAPE:
					get_tree().paused = true
						
func _on_continue_btn_up() -> void:
	self.visible = false
	get_tree().paused = false
		
# Esto será cambiado proximamente
func _on_save_btn_pressed() -> void:
	saveQsnDlg.visible = true
		
func _on_savenexit_btn_pressed() -> void: # Esto solo te lleva al inicio
	var menu_inicio = load("res://Scenes/menu_inicio.tscn")
	get_tree().paused = false
	get_tree().change_scene_to_packed(menu_inicio)
		
func _on_no_btn_pressed() -> void:
	saveQsnDlg.visible = false
		
func _on_yes_btn_pressed() -> void:
	saveQsnDlg.visible = false
	print("No implementado aún.")
		
