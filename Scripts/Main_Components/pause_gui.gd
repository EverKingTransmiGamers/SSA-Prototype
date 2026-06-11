class_name PauseGui extends CanvasLayer

var mainPaused:bool = false

func _process(_delta: float) -> void:
	# Esto pausará el juego si paused es cierto, de lo contrario lo continuará.
	match mainPaused:
		true:
			visible = true
			get_tree().paused = true
			if Input.is_action_just_pressed("key_esc"):
				mainPaused = false
		false:
			visible = false
			get_tree().paused = false
			if Input.is_action_just_pressed("key_esc"):
				mainPaused = true

func _on_continue_btn_pressed() -> void:
	mainPaused = false
		
# Esto será cambiado proximamente
func _on_restart_btn_pressed() -> void:
	mainPaused = false
		
func _on_exit_btn_pressed() -> void: # Esto solo te lleva al inicio
	var menu_inicio = load("res://Scenes/menu_inicio.tscn")
	get_tree().paused = false
	get_tree().change_scene_to_packed(menu_inicio)
		
