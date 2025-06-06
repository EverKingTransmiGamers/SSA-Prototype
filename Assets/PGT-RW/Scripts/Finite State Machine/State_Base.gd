class_name StateBase extends Node

# Referencia al nodo que utilizaremos
@onready var nodo_actual:Node = self.owner

var state_machine:StateMachine

#region

# Metodo que se ejecuta al entrar en el estado
func start():
	pass

func end():
	pass

#endregion
