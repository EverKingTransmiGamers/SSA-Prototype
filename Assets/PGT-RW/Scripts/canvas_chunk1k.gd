@tool
extends Node2D

const CELL_SIZE:int = 40
const CELL_LINE_POS:Vector2i = Vector2i(40, 40) # Esto controla el tamaño de las celdas
const GRID_SIZE:Vector2i = Vector2i(10, 10)
"""
ok, esta parte del codigo hace unas matematicas raras la verdad xd.
para saber como son, al parecer, esta operacion en la funcion:
Vector2(x_li * CELL_SIZE, 0)
en cada iteracion, se recorre los valores de los rangos de los
bucle for ya sea "x_li" or "y_li", y lo suma repetidas veces para hacer crecer el numero
"""
func _ready() -> void:
	call_deferred("draw_grid1k")

func draw_grid1k():
	for x_li in range(GRID_SIZE.x):
		var line1k: Line2D = Line2D.new()
		line1k.width = 2
		line1k.default_color = Color(0, 0, 0, 1)
		line1k.points = [Vector2(0, 0), Vector2(CELL_SIZE * GRID_SIZE.x, 0)]
		line1k.name = "Line2D_X"
		line1k.position = Vector2(0, x_li * CELL_LINE_POS.x)
		add_child.call_deferred(line1k)

	for y_li in range(GRID_SIZE.y):
		var line2k: Line2D = Line2D.new()
		line2k.width = 2
		line2k.default_color = Color(0, 0, 0, 1)
		line2k.points = [Vector2(0, 0), Vector2(0, CELL_SIZE * GRID_SIZE.y)]
		line2k.name = "Line2D_Y"
		line2k.position = Vector2(y_li * CELL_LINE_POS.y, 0)
		add_child.call_deferred(line2k)
