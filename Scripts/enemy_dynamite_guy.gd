extends CharacterBody2D

@export_group("Enemy Settings")
@export var HEALTH: int = 100
@export var SPEED = 1
@export var ACCEL = 5
@export var target_body: CharacterBody2D = null

@export_group("Throwable Settings")
##The speed of the throwable
@export var throw_speed = 500
##The range of the throwable (will also make the enemy stop at that range)
@export var throw_range = 300
##The rate that this enemy throws
@export var throw_rate = 1
##The amount of time in seconds before explosion
@export var fuse_length = 1.0


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var movement_component: Component_Movement = $component_movement
@onready var health_component: Component_Health = $component_health
@onready var hitbox: Component_Hitbox = $component_hitbox
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var target: Vector2
@onready var component_throwable_telegraph: Component_Throwable_Telegraph = $component_throwable_telegraph
@onready var can_throw: bool = true
@onready var throw_timer: Timer = $throw_rate


func _ready():
	movement_component.base_mov_speed = SPEED
	movement_component.base_acceleration = ACCEL
	movement_component.base_min_distance_to_target = throw_range
	throw_timer.wait_time = 1.0 / throw_rate
	
func _physics_process(delta):
	if target_body == null:
		target = get_global_mouse_position()
	else:
		target = target_body.position
	
	movement_component.set_target(target)
	movement_component.move(self, delta)
	
	if movement_component.reached_target():
		if can_throw:
			animation_player.play("Throwing")
			
			can_throw = false
			throw_timer.start()
			
			var t = preload("res://Scenes/Components/throwable.tscn")
			var t_instance: Throwable = t.instantiate()
			var d = preload("res://Scenes/Throwables/dynamite.tscn")
			var d_instance: Dynamite = d.instantiate()
			
			add_sibling(t_instance)
			t_instance.init_throwable()
			t_instance.set_speed(throw_speed)
			t_instance.set_throwable(d_instance)
			
			d_instance.fuse.wait_time = fuse_length
			d_instance.fuse.start()
			
			t_instance.set_origin(position - global_position)
			t_instance.set_destination(target - global_position)
			t_instance.create_line()
			t_instance.position = position
		else:
			if animation_player.current_animation == "walking":
				animation_player.stop()
			animation_player.queue("Idling")
			
		
		#component_throwable_telegraph.set_origin(position - global_position)
		#component_throwable_telegraph.set_destination(target - global_position)
		#component_throwable_telegraph.draw_parabola()
		#component_throwable_telegraph.clear_parabola()
	elif not movement_component.reached_target():
		animation_player.play("walking")
	flip_sprite()

func flip_sprite():
	if position.x < target.x:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true


func _on_throw_rate_timeout():
	can_throw = true
	throw_timer.stop()
