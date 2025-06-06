@tool
extends Node2D

const GRID_CHUNK_SIZE: Vector2i = Vector2i(400, 400)
const GRID_SIZE: Vector2 = Vector2(10, 6)

func _ready() -> void:
	for x_li in range(GRID_SIZE.x):
		for y_li in range(GRID_SIZE.y):
			var canvas_chunk:Node = preload("res://Scenes/Editor_Components/editor_canvas_chunk1k.tscn").instantiate()
			canvas_chunk.position = Vector2(x_li * GRID_CHUNK_SIZE.x, y_li * GRID_CHUNK_SIZE.y)
			add_child.call_deferred(canvas_chunk)
		
