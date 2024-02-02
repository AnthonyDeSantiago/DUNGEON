extends CharacterBody2D

@export var SPEED: int = 500

@onready var state_chart = $StateChart
@onready var animated_sprite_2d = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	velocity.y = Input.get_axis("up", "down")
	velocity.x = Input.get_axis("left", "right")
	
	velocity = velocity.normalized()
	
	velocity.x = velocity.x * SPEED
	velocity.y = velocity.y * SPEED
	
	print("Is Vel zero: " + str(velocity == Vector2(0, 0)))
	
	if velocity != Vector2(0, 0):
		state_chart.send_event("player_is_running")
		if velocity.x > 0:
			animated_sprite_2d.flip_h = false
		elif  velocity.x < 0:
			animated_sprite_2d.flip_h = true
	else:
		state_chart.send_event("player_is_idle")
	
	move_and_slide()
	
