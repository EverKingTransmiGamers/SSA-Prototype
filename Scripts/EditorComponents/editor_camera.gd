class_name EditorCamera extends Camera2D

var dragging:bool = false
var dragStartPos:Vector2
var cameraStartPos:Vector2

var zoom1k:float = 1.0

@export var debugInfoLabels:Dictionary[StringName, Label]

# Referencia al editor de niveles.
@onready var editorProto1K:EditorProto1K = self.owner

# Referencia a la interfaz principal.
@onready var cameraGui:CanvasLayer = %CanvasLayer

func _ready() -> void:
	debugInfoLabels[&"FPSInfo"].text = "FPS: " + str(Engine.get_frames_per_second())
		
# Control basico de la Cámara
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			if event.is_pressed() and editorProto1K.currentState == \
			editorProto1K.EditorStates.Drag:
				dragging = true
				dragStartPos = event.global_position
				cameraStartPos = self.global_position
					
			else:
				dragging = false
					
		# Se encargará del zoom de la cámara.
		match event.button_index:
			MouseButton.MOUSE_BUTTON_WHEEL_UP:
				zoom1k += 0.1
				zoom1k = clampf(zoom1k, 0.2, 10.0)
				self.zoom = Vector2(zoom1k, zoom1k)
					
			MouseButton.MOUSE_BUTTON_WHEEL_DOWN:
				zoom1k -= 0.1
				zoom1k = clampf(zoom1k, 0.2, 10.0)
				self.zoom = Vector2(zoom1k, zoom1k)
					
	# Esto se encarga de mover la cámara a la misma velocidad del mouse
	if dragging and event is InputEventMouseMotion:
		var dragZoomSpeed:float = 1.0 / self.zoom.x
		var mouseDelta = (event.global_position - dragStartPos) * dragZoomSpeed
		self.global_position = (cameraStartPos - mouseDelta)
					
# Actualiza las informaciones que le ponemos por cada fotograma visual.
func _process(_delta: float) -> void:
	debugInfoLabels[&"MouseChunkCoordsInfo"].text = "MouseChunkCoords: X: " + \
		str(editorProto1K.get_chunk_coords(get_global_mouse_position() ).x ) + ", Y: " + \
		str(editorProto1K.get_chunk_coords(get_global_mouse_position() ).y )
			
	debugInfoLabels[&"CamChunkPosInfo"].text = "CameraChunkPos: X: " + \
		str(editorProto1K.get_chunk_coords(self.position).x ) + ", Y: " + \
		str(editorProto1K.get_chunk_coords(self.position).y )
			
	debugInfoLabels[&"CamCoordsInfo"].text = "CameraCoords: X: " + str(self.position.x) + ", Y: " + str(self.position.y)
			
	debugInfoLabels[&"CamZoomInfo"].text = "CameraZoom: " + str(self.zoom.x)
			
func _on_exit_btn_pressed() -> void:
	var menuInicio:PackedScene = load("res://Scenes/menu_inicio.tscn")
	get_tree().change_scene_to_packed(menuInicio)
		
func _info_updater_timer_timeout() -> void:
	debugInfoLabels[&"FPSInfo"].text = "FPS: " + str(Engine.get_frames_per_second())
		
#region Son las señales de los botones
@warning_ignore("unused_parameter")
func _on_boton_paint_toggled(toggled_on: bool) -> void:
	editorProto1K.currentState = editorProto1K.EditorStates.Paint
@warning_ignore("unused_parameter")
func _on_boton_drag_toggled(toggled_on: bool) -> void:
	editorProto1K.currentState = editorProto1K.EditorStates.Drag
#endregion
