extends Node2D
class_name Component_Throwable_Telegraph

@export var point_origin: Vector2 = Vector2(0,0)
@export var point_destination: Vector2 = Vector2(200, 200)

@onready var parabola_line:Line2D = $Line2D

func set_origin(origin: Vector2):
	point_origin = origin

func set_destination(destination: Vector2):
	point_destination = destination
	
func draw_parabola():
	var a = (point_destination.y - point_origin.y) / ((point_destination.x - point_origin.x) * (point_destination.x - point_origin.x))
	var b = -2 * a * point_origin.x
	var c = point_origin.y - a * point_origin.x * point_origin.x - b * point_origin.x
	
	parabola_line.default_color = Color(1, 0, 0)

	for x in range(int(point_origin.x), int(point_destination.x) + 1):
		var y = a * x * x + b * x + c
		parabola_line.add_point(Vector2(x, y))

func clear_parabola():
	parabola_line.clear_points()
