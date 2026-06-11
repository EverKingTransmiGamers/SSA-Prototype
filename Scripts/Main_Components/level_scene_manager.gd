class_name LevelSceneManager
extends Node

const SS_Levels_Path:String = "res://Scenes/Main_Levels/"
const level_format:String = ".tscn"

# Definimos al selector de niveles para que pueda ser instanciado
const level_chooser:PackedScene = preload(LevelsManager.SS_Level_Chooser)
var level_chooser_inst = level_chooser.instantiate()

# Referencias a las clases
@onready var Player1K:CharacterBody2D = load("res://Scenes/Player.tscn").instantiate()
@onready var player_spawner:PlayerSpawner = $Player_Spawner

# Referencias a la maquina de estados y sus estados
@onready var my_state_machine:StateMachine = $StateMachine
@onready var lvl_state_level = $StateMachine/LvlStateLevel

# Ruta del nivel para viajar, pero el nombre cambia dinamicamente
var current_level_name:String

enum PauseStates {Chooser, Level}
var nodo_pausa_actual:= PauseStates.Chooser

func _ready() -> void:
	pass
		
func _get_level_name() -> void:
	pass
			
func execute_reload() -> void:
	#lvl_state_level.reload_game()
	pass
		
