# Estado de Selector de Niveles
extends StateBase

# Variable para definir el nodo a controlar
var LvlScnMgr:LevelSceneManager

func start():
	# Aqui defino que el nodo actual a controlar sera el gestor de escenas de niveles
	LvlScnMgr = nodo_actual
		
	# Aqui instancio al nivel que me permitirá escoger entre varios niveles
	LvlScnMgr.add_child(LvlScnMgr.level_chooser_inst)
		
	LvlScnMgr.player_spawner.call_deferred("spawn_player") # Invoca al jugador
	print(LvlScnMgr.Player1K)
		
func en_process(_delta) -> void:
	LvlScnMgr.Player1K.toWarp.connect(_warp_level)
	# Prueba para ver si puedo borrar al jugador
	#if Input.is_action_just_pressed("debug1"):
		#LvlScnMgr.player_spawner.delete_player()
		#LvlScnMgr.level_chooser_inst.queue_free()
		#state_machine.change_to("LvlStateLevel")
			
func _warp_level() -> void:
	LvlScnMgr.player_spawner.delete_player()
	LvlScnMgr.level_chooser_inst.queue_free()
	state_machine.change_to("LvlStateLevel")
		
