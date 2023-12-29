extends Node2D
class_name Component_Movement

@export var base_mov_speed: float = 0
@export var base_acceleration: float = 2
@export var base_min_distance_to_target: = 100

@onready var velocity: Vector2 = Vector2.ZERO

@onready var nav_agent: NavigationAgent2D = $nav_agent
@onready var target: Vector2
@onready var direction: Vector2
@onready var enabled: bool = true

'''
Setter method for setting nav's target_position.

:param target_position: new value of nav's target_position
'''
func set_target(target_position: Vector2):
	target = target_position
	nav_agent.target_position = target_position

func get_next_position():
	return nav_agent.get_next_path_position() - global_position

func stop_moving():
	nav_agent.process_mode = Node.PROCESS_MODE_DISABLED
	enabled = false

func start_moving():
	nav_agent.process_mode = Node.PROCESS_MODE_INHERIT
	enabled = true

func distance_to_target() -> float:
	if nav_agent.target_position != null:
		return nav_agent.distance_to_target()
	else:
		print("component_movement: distance_to_target: target is null!")
		return -1.0

func reached_target() -> bool:
	if get_parent().position.distance_to(nav_agent.target_position) <= base_min_distance_to_target:
		return true
	else:
		return false

func move(body: CharacterBody2D, delta):
	if not reached_target():
		velocity = get_next_position() * base_mov_speed
		#velocity = velocity.lerp(get_next_position() * base_mov_speed, base_acceleration * delta)
		body.velocity = velocity
		body.move_and_slide()
		
