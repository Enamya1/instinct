extends CharacterBody2D

@onready var health_bar: ProgressBar = $ProgressBar
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var character_body_2d: CharacterBody2D = $"."
@onready var player: CharacterBody2D = $"."
@onready var ray_cast_2d: RayCast2D = $RayCast2D


const SPEED = 100.0

@export var speed_cof =2
@export var health:int =100
@export var damege_rate:int = 100





func _physics_process(delta: float) -> void:
	
	
	var direction_y := Input.get_axis("move_up", "move_down")
	var direction_x := Input.get_axis("move_L", "move_R")
	var animation_direction=Vector2(direction_x,direction_y)
	health_bar.value=health
	check_if_player_die(health)
	#handle_animation_running(Vector2(direction_x,direction_y))
	
	
	if Input.is_action_pressed("move_f"):
		animated_sprite_2d.play("attack_side")
		deel_damge(ray_cast_2d.get_collider())
	if direction_y or direction_x:
		
		velocity.y = direction_y * SPEED
		velocity.x = direction_x * SPEED
		rotation_of_the_raycast(Vector2(direction_x,direction_y))
		
		
	
		
	else:
		
		
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.x, 0, SPEED)
	handle_animation(animation_direction,velocity)
	move_and_slide()
func check_if_player_die(health)-> void:
	if health == 0:
		Engine.time_scale=0
func handle_animation_standing(direction: Vector2) -> void:
	if direction.x != 0:
		animated_sprite_2d.flip_h = direction.x < 0
		animated_sprite_2d.play("stand_side")
	elif direction.y > 0:
		animated_sprite_2d.play("default")
	elif direction.y < 0:
		animated_sprite_2d.play("stand_up")

func handle_animation_running(direction: Vector2) -> void:
	if direction.x != 0:
		animated_sprite_2d.flip_h = direction.x < 0
		animated_sprite_2d.play("run_side")
	elif direction.y > 0:
		animated_sprite_2d.play("run_down")
	elif direction.y < 0:
		animated_sprite_2d.play("run_up")

	
func rotation_of_the_raycast(vec:Vector2)->void:
	#pi <--, 0 -->
	#pi/2 |, *-pi/2
	
	if vec.x :
		if vec.x == 1:
			vec.x=0
		ray_cast_2d.rotation= vec.x *PI
	if vec.y:
		ray_cast_2d.rotation= vec.y *PI/2
func deel_damge(target:Object)->void:
	if not(target == null):
		target.mob_health -=damege_rate





func handle_animation(direction: Vector2,vel) -> void:
	if direction.length() > 0:
		# Handle running animation
		animated_sprite_2d.flip_h = direction.x < 0
		if direction.y > 0:
			animated_sprite_2d.play("run_down")
		elif direction.y < 0:
			animated_sprite_2d.play("run_up")
		else:
			animated_sprite_2d.play("run_side")
	else:
		# Handle standing animation
		if vel.x != 0:
			animated_sprite_2d.flip_h = vel.x < 0
			animated_sprite_2d.play("stand_side")
		elif vel.y > 0:
			animated_sprite_2d.play("default")
		elif vel.y < 0:
			animated_sprite_2d.play("stand_up")
