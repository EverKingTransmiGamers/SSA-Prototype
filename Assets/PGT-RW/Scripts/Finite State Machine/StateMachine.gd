class_name StateMachine extends Node

# Esta version de la maquina de estados fue hecho o descubierto por Findemor.
# Gracias Findemor por enseñar una Maquina de Estados Finita en español

# Nodo que controlaremos con la maquina
@onready var nodo_actual:Node = self.owner

@export var default_state:StateBase

var estado_actual:StateBase = null

func _ready() -> void:
	call_deferred("_state_defl_start")
		
func _state_defl_start():
	estado_actual = default_state
	_state_start()
		
func _state_start() -> void:
	prints("StateMachine:", nodo_actual.name, "Iniciar estado:", estado_actual.name)
	# Configuramos el estado
	estado_actual.nodo_actual = nodo_actual
	estado_actual.state_machine = self
	estado_actual.start()
		
# Esta funcion cambiara el estado actual del objeto,
# si le pasamos un nodo de estado como nuevo parametro
func change_to(new_state:String):
	if estado_actual and estado_actual.has_method("end"):
		estado_actual.end()
	estado_actual = get_node(new_state)
	_state_start()
		
#region metodos que se ejecutan solos
func _process(delta: float) -> void:
	if estado_actual and estado_actual.has_method("en_process"):
		estado_actual.en_process(delta)
			
func _physics_process(delta: float) -> void:
	if estado_actual and estado_actual.has_method("en_fisi_proces"):
		estado_actual.en_fisi_proces(delta)
		#print("Se ejecuta primero.")
			
func _unhandled_input(event: InputEvent) -> void:
	if estado_actual and estado_actual.has_method("en_unhand_input"):
		estado_actual.en_unhand_input(event)
			
func _input(event: InputEvent) -> void:
	if estado_actual and estado_actual.has_method("en_input"):
		estado_actual.en_input(event)
			
func _unhandled_key_input(event: InputEvent) -> void:
	if estado_actual and estado_actual.has_method("en_unhand_key_input"):
		estado_actual.en_unhand_key_input(event)
			
#endregion
