extends Node2D
class_name Throwable

@export var point_origin: Vector2 = Vector2(0,0)
@export var point_destination: Vector2 = Vector2(400, 400)
@export var speed: float = 50

var throwable = null

@onready var path: Path2D = %Path2D
@onready var path_follow_2d: PathFollow2D = %PathFollow2D
@onready var parabola_line:Curve2D

func _ready():
	path = $Path2D
	path_follow_2d = $PathFollow2D
	parabola_line = Curve2D.new()

func _process(delta):
	if path != null and path_follow_2d != null:
		if throwable != null:
			progress(delta)
		

func init_throwable():
	path = $Path2D
	path_follow_2d = %PathFollow2D
	parabola_line = Curve2D.new()
	
	#print("path: ", path, "path_foll: ", path_follow_2d)

func set_throwable(object):
	if path_follow_2d == null:
		path_follow_2d = $PathFollow2D
	throwable = object
	path_follow_2d.add_child(throwable)


func set_origin(origin: Vector2):
	point_origin = origin

func set_destination(destination: Vector2):
	point_destination = destination
	
func create_parabola():
	if path == null:
		print("path is null")
	else:
		var a = (point_destination.y - point_origin.y) / ((point_destination.x - point_origin.x) * (point_destination.x - point_origin.x))
		var b = -2 * a * point_origin.x
		var c = point_origin.y - a * point_origin.x * point_origin.x - b * point_origin.x

		for x in range(int(point_origin.x), int(point_destination.x) + 1):
			var y = a * x * x + b * x + c
			parabola_line.add_point(Vector2(x, y))
		path.curve = parabola_line
		
func create_line():
	if path == null:
		print("path is null")
	else:
		var y2 = point_destination.y
		var y1 = point_origin.y
		var x2 = point_destination.x
		var x1 = point_origin.x
		
		var slope = (y2 - y1) / (x2 - x1)
		if x2 < x1:
			for x in range(int(point_origin.x), int(point_destination.x) + 1, -1):
				var y = slope * x
				parabola_line.add_point(Vector2(x, y))
		else:
			for x in range(int(point_origin.x), int(point_destination.x) + 1):
				var y = slope * x
				parabola_line.add_point(Vector2(x, y))
		path.curve = parabola_line
	
func progress(delta):
	path_follow_2d.progress += speed * delta
	if path_follow_2d.get_child_count() == 0:
		queue_free()

'''
Setter for throwable speed

:param value: new value for speed
'''
func set_speed(value):
	speed = value

