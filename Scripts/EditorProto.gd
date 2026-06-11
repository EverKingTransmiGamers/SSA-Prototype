#@tool
class_name EditorProto1K extends Node2D

#region referencias a los componentes del editor y al jugador.
@onready var camera1K:EditorCamera = %EditorCamera1K
@onready var editorPauseGUI:EditorPauseGui = %EditorPauseGUI
@onready var objectCanvas:EditorObjectCanvas = %ObjectCanvas1K
var player1k:PackedScene = load("res://Scenes/Player.tscn")
var can_esc:bool = false
var can_respawn:bool = true
#endregion

# Configura el nombre del nivel.
@export var nombreDelNivel:String

# Configuraciones iniciales del chunk.
const CELL_SIZE:int = 56
const GRID_SIZE:int = 10
@export var chunkSize:int = CELL_SIZE * GRID_SIZE
@export var renderDistance:int = 7
var currentTargetPos:Vector2
var currentLayer:int = 0

enum EditorStates {
	Paint,
	Drag,
	Playtest,
	None
}
@export var currentState:EditorStates
var oldState:EditorStates

func _process(_delta: float) -> void:
	# Mini máquina de estados para que cada estado haga sus funciones.
	match currentState:
		EditorStates.Paint:
			camera1K.enabled = true
			camera1K.cameraGui.visible = true
			can_respawn = true
					
			currentTargetPos = camera1K.position
			if Input.is_action_just_pressed(&"debug_l"):
				oldState = currentState
				currentState = EditorStates.Playtest
					
		EditorStates.Drag:
			camera1K.enabled = true
			camera1K.cameraGui.visible = true
			can_respawn = true
					
			currentTargetPos = camera1K.position
			if Input.is_action_just_pressed(&"debug_l"):
				oldState = currentState
				currentState = EditorStates.Playtest
					
		EditorStates.Playtest:
			# Esto comprobará si el jugador existe, por ende su posición se usará
			# para que se carguen los chunks mientras se mueve el jugador.
			if can_respawn:
				camera1K.enabled = false
				camera1K.cameraGui.visible = false
				_player_spawn()
				can_respawn = false
					
			if self.has_node("Player"):
				var player1K:PlayerSS = get_node("Player")
				currentTargetPos = player1K.position
					
			if Input.is_action_just_pressed(&"debug_l"):
				if self.has_node("Player"):
					var player1K:PlayerSS = get_node("Player")
					player1K.queue_free()
				currentState = oldState
					
# Spawnea al jugador en el editor
func _player_spawn() -> void:
	var playerInst:PlayerSS = player1k.instantiate()
	playerInst.position = %PlayerSpawn.global_position
	add_child(playerInst)
	currentTargetPos = playerInst.position
		
# Esto obtendrá las coords del chunk o del mouse en sus unidades.
func get_chunk_coords(pos1k:Vector2) -> Vector2i:
	return Vector2i(
		floori(pos1k.x / chunkSize),
		floori(pos1k.y / chunkSize)
	)
		
# Esto obtendrá las posiciones en las coords del motor del chunk o del mouse.
func get_chunk_pos(pos1k:Vector2) -> Vector2:
	return Vector2(
		floori(chunkSize * pos1k.x),
		floori(chunkSize * pos1k.y)
	)
		
