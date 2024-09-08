extends CharacterBody2D
var speed = 700
@export var cof_speed =10
@export var damege_rate=5
@export var mob_health =50 
@onready var player =get_node("/root/main_game/player")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D



func _ready() -> void:
	pass
func _process(delta: float) -> void:
	
	if mob_health  <0 :
		queue_free()
	var direction_to_player = global_position.direction_to(player.global_position)
	velocity = direction_to_player  * speed*delta *cof_speed
	
	handel_animation(velocity)
	move_and_slide()
	
	

func normal_vec(vec:Vector2)->Vector2:
	var x:int
	var y:int
	if vec.x == 0:
		vec.x=0
	if vec.y == 0:
		vec.y=0
	else:
		x= vec.x/abs(vec.x)
		y= vec.y/abs(vec.y)
	return Vector2(x,y)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body ==player :
		animated_sprite_2d.play("take_damge")
		player.health-=damege_rate
		
		
func handel_animation(speed_vec: Vector2)-> void :
	if speed_vec.x>0 :
		animated_sprite_2d.flip_h=false
	if speed_vec.x< 0 :
		animated_sprite_2d.flip_h = true
	else :
		animated_sprite_2d.play("move_side")
