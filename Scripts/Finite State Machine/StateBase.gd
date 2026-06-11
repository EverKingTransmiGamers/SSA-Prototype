class_name StateBase extends Node

# Referencia al nodo que utilizaremos
@onready var nodo_actual:Node = self.owner

var state_machine:StateMachine

#region
# El metodo start se ejecuta al entrar en cualquier estado
func start() -> void:
	pass
		
func end() -> void:
	pass
		
#endregion

#region ayudas de funciones
@warning_ignore("unused_parameter")
func en_process(delta:float) -> void:
	pass
			
@warning_ignore("unused_parameter")
func en_fisi_proces(delta:float) -> void:
	pass
			
@warning_ignore("unused_parameter")
func en_unhand_input(event:InputEvent) -> void:
	pass
			
@warning_ignore("unused_parameter")
func en_input(event:InputEvent) -> void:
	pass
			
@warning_ignore("unused_parameter")
func en_unhand_key_input(event:InputEvent) -> void:
	pass

#endregion
