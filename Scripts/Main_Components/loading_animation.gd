extends CanvasLayer

var mainMenuScene:PackedScene

func _ready() -> void:
	RenderingServer.set_default_clear_color(Color("000000"))
	$MainAnimationPlayer1K.play("Loading1K")
		
func _load_menu_scene() -> void:
	mainMenuScene = load("res://Scenes/menu_inicio.tscn")
		
func _changeToMainMenu() -> void:
	get_tree().change_scene_to_packed(mainMenuScene)
		
