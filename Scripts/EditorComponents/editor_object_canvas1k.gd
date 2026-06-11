#@tool
class_name EditorObjectCanvas extends Node2D

# Referncias a la rutas del chunk donde se almacenará los objetos pintados.
const buildChunk:PackedScene = preload("res://Scenes/Editor_Components/canvas_chunk.tscn")

@onready var editorProto1K:EditorProto1K = self.owner

var loadedChunks:Dictionary = {}
var lastCamChunkPos:Vector2i

func _ready() -> void:
	_update_chunks()
	lastCamChunkPos = editorProto1K.get_chunk_coords(editorProto1K.currentTargetPos)
		
# Este temporizador carga los chunks cada 0.1 segundos
func _updateChunk_timer_timeout() -> void:
	var currentTargetChunkPos:Vector2i = editorProto1K.get_chunk_coords(editorProto1K.currentTargetPos)
	if currentTargetChunkPos != lastCamChunkPos:
		_update_chunks()
		lastCamChunkPos = currentTargetChunkPos
			
# Este será el cargador dinámico de chunks dependiendo de la posición de la cámara.
func _update_chunks() -> void:
	# Esto es para obtener la posición de la cámara actual
	# que se utilizará como centro para cargar los chunks
	var currentTargetChunkPos:Vector2i = editorProto1K.get_chunk_coords(editorProto1K.currentTargetPos)
	
	# Esta sección cargará la lista de chunks que necesitaremos cargar.
	var chunksToLoad:Array = []
	for chunkX in range(-editorProto1K.renderDistance, editorProto1K.renderDistance + 1):
		for chunkY in range(-editorProto1K.renderDistance, editorProto1K.renderDistance + 1):
			var chunkCoords:Vector2i = currentTargetChunkPos + Vector2i(chunkX, chunkY)
			chunksToLoad.append(chunkCoords)
				
	# Esta sección enviará las coords de los chunks a cargar y los cargará.
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
				
# Esto carga el chunk según los datos que se les mande.
func load_chunk(chunkCoords:Vector2i) -> void:
	var buildChunkInst:Node2D = buildChunk.instantiate()
	var chunkPath:String = "res://Scenes/Main_Levels/" \
		+ editorProto1K.nombreDelNivel + "/Chunks/ChunkTest#" \
		+ _chunkCoords_to_dictKey(chunkCoords) + ".tres"
	buildChunkInst.position = editorProto1K.get_chunk_pos(chunkCoords)
	buildChunkInst.name = &"Chunk#" + str(chunkCoords.x) + "," + str(chunkCoords.y)
	# Estas condicionales comprueban la existencia de un archivo de chunk
	# dentro de la carpeta de un nivel, si lo encuentran lo cargan.
	if FileAccess.file_exists(chunkPath):
		print("Existe el Chunk")
		var chunkData:LevelChunkData = load(chunkPath)
		add_child(buildChunkInst)
		loadedChunks[_chunkCoords_to_dictKey(chunkCoords)] = chunkData.levelChunk1K[chunkCoords]
		loadedChunks[_chunkCoords_to_dictKey(chunkCoords)]["BuildChunkPath"] = buildChunkInst
		var loadObject:PackedScene = load("res://Scenes/Objects/blockbase1k.tscn")
		for objects:Vector2i in loadedChunks[_chunkCoords_to_dictKey(chunkCoords)][&"Objects"][0]:
			var instObject:Node2D = loadObject.instantiate()
			instObject.position = objects
			
			
	else:
		print("El Chunk de las coords: ", Vector2i(chunkCoords), " No existe.")
		add_child(buildChunkInst)
		loadedChunks[_chunkCoords_to_dictKey(chunkCoords)] = buildChunkInst
		
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
		
