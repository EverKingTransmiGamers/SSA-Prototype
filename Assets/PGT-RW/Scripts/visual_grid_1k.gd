#@tool
extends Node2D

@onready var editorProto1K:EditorProto1K = self.owner

var visualChunk:PackedScene = load("res://Scenes/Editor_Components/visual_grid_chunk.tscn")

var loadedChunks:Dictionary = {}
var lastCamChunkPos:Vector2i

func _ready() -> void:
	_update_visual_chunks()
	lastCamChunkPos = editorProto1K.get_chunk_coords(editorProto1K.currentTargetPos)
		
func _updateChunksTimer_timeout() -> void:
	var currentCamChunkPos:Vector2i = \
		editorProto1K.get_chunk_coords(editorProto1K.currentTargetPos)
			
	if currentCamChunkPos != lastCamChunkPos:
		_update_visual_chunks()
		lastCamChunkPos = currentCamChunkPos
			
# Este será el cargador dinámico de chunks dependiendo de la posición de la cámara.
func _update_visual_chunks() -> void:
	# Esto es para obtener la posición de la cámara actual
	# que se utilizará como centro para cargar los chunks
	var currentCameraChunkPos:Vector2i = editorProto1K.get_chunk_coords(editorProto1K.currentTargetPos)
	
	# Esta sección cargará la lista de chunks que necesitaremos cargar.
	var chunksToLoad:Array = []
	for chunkX in range(-editorProto1K.renderDistance, editorProto1K.renderDistance + 1):
		for chunkY in range(-editorProto1K.renderDistance, editorProto1K.renderDistance + 1):
			if currentCameraChunkPos.x <= 100:
				var chunkCoords:Vector2i = currentCameraChunkPos + Vector2i(chunkX, chunkY)
				chunksToLoad.append(chunkCoords)
				
	# Esta sección enviará los chunks a cargar y los cargará.
	for chunkCoords in chunksToLoad:
		if not loadedChunks.has(_chunkCoords_to_dictKey(chunkCoords)):
			call_thread_safe(&"load_chunk", chunkCoords)
				
	# Enviar chunks fuera del rango de renderizado a descargarse.
	""" Detecta si los chunks a cargar no son los mismos cargados, es decir,
		si los chunks que se van a cargar no son los mismos que los que están cargados ahora mismo,
		significa que están fuera de pantalla, por ende a esos chunks los descargará. """
	var chunksToUnload:Array = []
	for chunkKey:String in loadedChunks.keys():
		var chunkCoords:Vector2i = _dictKey_to_chunkCoords(chunkKey)
		if not chunksToLoad.has(chunkCoords):
			chunksToUnload.append(chunkKey)
				
	# Detectará los chunks a descargar y los descargará.
	for chunkKey in chunksToUnload:
		call_thread_safe(&"unload_chunk", chunkKey)
				
func load_chunk(chunkCoords:Vector2i) -> void:
	var visualChunkInst:Node2D = visualChunk.instantiate()
	visualChunkInst.position = editorProto1K.get_chunk_pos(chunkCoords)
	visualChunkInst.name = &"Chunk#" + str(chunkCoords.x) + "," + str(chunkCoords.y)
	add_child(visualChunkInst)
	loadedChunks[_chunkCoords_to_dictKey(chunkCoords)] = visualChunkInst
		
func unload_chunk(chunkKey:String) -> void:
	if loadedChunks.has(chunkKey):
		var chunkNode:Node2D = loadedChunks[chunkKey]
		chunkNode.queue_free()
		loadedChunks.erase(chunkKey)
		
func _chunkCoords_to_dictKey(chunkCoords:Vector2i) -> String:
	return str(chunkCoords.x) + "," + str(chunkCoords.y)
		
func _dictKey_to_chunkCoords(dictKey:String) -> Vector2i:
	var splitCoords:Array = dictKey.split(",")
	return Vector2i(
		int(splitCoords[0]),
		int(splitCoords[1])
	)
		
# Versión sin probar y terminar del generador de líneas visuales de las celdas
#func _update_visual_chunks() -> void:
	#var currentCamChunkPos:Vector2 = \
		#editorProto1K.get_chunk_coords(editorProto1K.camera1K.position)
			#
	#var currentCamPos:Vector2 = editorProto1K.get_chunk_pos(currentCamChunkPos)
	#for xLine in range(editorProto1K.GRID_SIZE):
		## Esta de aca dibujara las lineas horizontales distribuyendolas verticalmente
		#draw_line(
			#Vector2(currentCamPos.x, currentCamPos.y + (editorProto1K.CELL_SIZE * xLine) ),
			#Vector2(currentCamPos.x + editorProto1K.chunkSize, currentCamPos.y + (editorProto1K.CELL_SIZE * xLine) ),
			#Color("000000ff"), -1.0, false
			#)
				#
