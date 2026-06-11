# Estado de Nivel Actual
extends StateBase

var LvlScnMgr:LevelSceneManager

var level_path:TestLevelClass = preload("res://Scenes/Main_Levels/test_world1.tscn").instantiate()

func start() -> void:
	LvlScnMgr = nodo_actual
		
	LvlScnMgr.nodo_pausa_actual = LvlScnMgr.PauseStates.Level
	LvlScnMgr.add_child(level_path)
	LvlScnMgr.player_spawner.position = level_path.playerSpawnPosRef.global_position
	LvlScnMgr.player_spawner.delete_player()
	
	LvlScnMgr.player_spawner.spawn_player()
		
func reload_game() -> void:
	LvlScnMgr.add_child(level_path)
	LvlScnMgr.player_spawner.delete_player()
	LvlScnMgr.player_spawner.spawn_player()
