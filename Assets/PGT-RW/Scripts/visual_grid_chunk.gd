@tool
extends Node2D

const CELL_SIZE:int = 56 # Esto controla el tamaño de las celdas visuales
const GRID_SIZE:Vector2 = Vector2(10, 10) # Y esto controlara cuantas lineas se dibujaran
# Para dibujar cierta cantidad de cuadriculas

"""
Esta parte del codigo hace unas matematicas raras la verdad xd.
para saber como son, al parecer, esta operacion en la funcion:
Vector2(CELL_SIZE* x_main, 0)
en cada iteracion, se recorre los valores de los rangos de los
bucle for ya sea "x_main" or "y_main", y lo suma repetidas veces para hacer crecer el numero
"""

func _draw() -> void:
	# Este bucle dibujara las lineas visuales para formar las cuadriculas visuales del editor
	for x_main in range(GRID_SIZE.x):
		for y_main in range(GRID_SIZE.y):
			# Esta de aca dibujara las lineas verticales distribuyendolas horizontalmente
			draw_line(Vector2(CELL_SIZE * x_main, 0), Vector2(CELL_SIZE * x_main, CELL_SIZE * GRID_SIZE.y), Color("000000ff"), -1.0, false)
			# Esta de aca dibujara las lineas horizontales distribuyendolas verticalmente
			draw_line(Vector2(0, CELL_SIZE * y_main), Vector2(CELL_SIZE * GRID_SIZE.x, CELL_SIZE * y_main), Color("000000ff"), -1.0, false)
				
