extends Node2D
class_name Dynamite

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var fuse: Timer = $Fuse
@onready var explosion_timer: Timer = $Explosion_Timer
@onready var fuse_length: float = 1.0


func _ready():
	animation_player.play("lit_fuse")
	

func init_dynamite():
	animated_sprite_2d = $AnimatedSprite2D
	animation_player = $AnimationPlayer
	fuse = $Fuse
	explosion_timer = $Explosion_Timer
	animation_player.play("lit_fuse")
	
func _process(delta):
	if not animation_player.is_playing():
		queue_free()


func _on_fuse_timeout():
	animation_player.play("explosion")


