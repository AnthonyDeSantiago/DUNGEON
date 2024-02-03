extends CharacterBody2D

@export var SPEED: int = 500

@onready var state_chart = $StateChart
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var isAttacking: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if not isAttacking:
		velocity.y = Input.get_axis("up", "down")
		velocity.x = Input.get_axis("left", "right")
	
		velocity = velocity.normalized()
	
		velocity.x = velocity.x * SPEED
		velocity.y = velocity.y * SPEED
	
		if velocity != Vector2(0, 0):
			state_chart.send_event("player_is_running")
			if velocity.x > 0:
				animated_sprite_2d.flip_h = false
			elif  velocity.x < 0:
				animated_sprite_2d.flip_h = true
		else:
			state_chart.send_event("player_is_idle")
	
		move_and_slide()
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		state_chart.send_event("player_is_attacking")
	


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Attack_Side":
		isAttacking = false


func _on_attack_side_state_entered():
	isAttacking = true



