extends CharacterBody2D

@export var SPEED: int = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	velocity.y = Input.get_axis("up", "down")
	velocity.x = Input.get_axis("left", "right")
	
	print("velocity.y: ", velocity.y)
	print("velocity.x: ", velocity.x)
	
	velocity = velocity.normalized()
	print("Velocity: ", velocity)
	
	velocity.x = velocity.x * SPEED
	velocity.y = velocity.y * SPEED
	
	move_and_slide()
	
