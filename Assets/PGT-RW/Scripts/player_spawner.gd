class_name PlayerSpawner extends Node2D

@onready var LvlScnMgr:LevelSceneManager = self.owner

func spawn_player() -> void: # Esto hará aparecer al jugador si su funcion es llamada para ser ejecutada
	LvlScnMgr.Player1K.global_position = position
	LvlScnMgr.add_child(LvlScnMgr.Player1K)
		
func delete_player() -> void: # Esto borrará al jugador cuando la función sea llamada
	if LvlScnMgr.has_node("Player"):
		LvlScnMgr.remove_child(LvlScnMgr.Player1K)
		
