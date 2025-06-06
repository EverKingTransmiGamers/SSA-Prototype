class_name Editor_Proto1K
extends Node2D

const CELL_SIZE: Vector2 = Vector2(40, 40)
const GRID_SIZE: Vector2 = Vector2(100, 60)

@onready var Camera1K: Node = $Editor_Camera

var current_block: PackedScene = ObjectsManager1K.Block1K

var player1k: Node = preload("res://Scenes/player.tscn").instantiate()
var can_esc: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("key_esc") and can_esc:
		get_tree().change_scene_to_file("res://Scenes/menu_inicio.tscn")
	_player_spawn(event)
	
	if event is InputEventMouseButton:
		if event.pressed:
			# obtine la posicion global del Mouse
			var mouse_position: Vector2 = get_global_mouse_position()
			# convierte la posicion del mouse a coords de celdas
			var cell_coords:= _get_cell_coords(mouse_position)
				
			if event.button_index == MOUSE_BUTTON_LEFT:
				place_block(cell_coords)
					
			if event.button_index == MOUSE_BUTTON_RIGHT:
				remove_block(cell_coords)

func _get_cell_coords(pos1k: Vector2) -> Vector2:
	var cell_x: int = (pos1k.x / CELL_SIZE.x)
	var cell_y: int = (pos1k.y / CELL_SIZE.y)
	return Vector2(cell_x, cell_y)

func place_block(cell_coords: Vector2):
	# Verificar si la celda está dentro de los límites de la cuadrícula
	if cell_coords.x >= 0 and cell_coords.x < GRID_SIZE.x and cell_coords.y >= 0 and cell_coords.y < GRID_SIZE.y:
		print(cell_coords.x,", ", cell_coords.y)
		if not has_block_at(cell_coords):
			var obj_pnt = current_block.instantiate()
			obj_pnt.position = cell_coords * CELL_SIZE + CELL_SIZE / 2
			$Object_Layer.add_child.call_deferred(obj_pnt)
				
func remove_block(cell_coords: Vector2):
	# Verificar si la celda está dentro de los límites de la cuadrícula
	if cell_coords.x >= 0 and cell_coords.x < GRID_SIZE.x and cell_coords.y >= 0 and cell_coords.y < GRID_SIZE.y:
		# Buscar y eliminar el bloque en esta celda
		for obj_pnt in $Object_Layer.get_children():
			if obj_pnt.position == cell_coords * CELL_SIZE + CELL_SIZE / 2:
				obj_pnt.queue_free()
					
func has_block_at(cell_coords: Vector2) -> bool:
	# Verificar si ya hay un bloque en esta celda
	for obj_pnt in $Object_Layer.get_children():
		if obj_pnt.position == cell_coords * CELL_SIZE + CELL_SIZE / 2:
			return true
	return false

func _player_spawn(event):
	if event.is_action_pressed("key_l"):
		player1k.position = $Player_Spawn.position
		add_child.call_deferred(player1k)
		if Camera1K:
			Camera1K.queue_free()
		can_esc = true
