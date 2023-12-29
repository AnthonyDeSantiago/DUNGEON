extends CharacterBody2D

@export var SPEED = 1
@export var ACCEL = 5
@export var min_distance_to_target = 100
@export var target_body: CharacterBody2D = null

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var movement_component: Component_Movement = $component_movement
@onready var health_component: Component_Health = $component_health
@onready var hitbox: Component_Hitbox = $component_hitbox
@onready var animation_player = $AnimationPlayer
@onready var target: Vector2


func _ready():
	movement_component.base_mov_speed = SPEED
	movement_component.base_acceleration = ACCEL
	movement_component.base_min_distance_to_target = min_distance_to_target
	
func _physics_process(delta):
	if target_body == null:
		target = get_global_mouse_position()
	else:
		target = target_body.position
	
	movement_component.set_target(target)
	movement_component.move(self, delta)
	
	if movement_component.reached_target():
		animation_player.play("Throwing")
	elif not movement_component.reached_target():
		animation_player.play("walking")
	flip_sprite()

func flip_sprite():
	if position.x < target.x:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true
