extends CharacterBody2D

@export var speed:float = 0.0
@export var jump_force: float = 0.0

@export var is_ducking: bool = false #is player crouching

@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var player_light_position: Node2D = $Node2D

func _physics_process(delta):
	apply_gravity(delta) # apply gravity to the player
	handle_inputs() # get inputs and change state of player
	
	move_and_slide()
	update_movement_animation(velocity)

func _process(delta):
	pass

func apply_gravity(delta):
	if !is_on_floor(): # only if in air
		velocity.y += delta * ProjectSettings.get_setting("physics/2d/default_gravity")

func handle_inputs():
	if Input.is_action_just_pressed("ui_select") and is_on_floor(): #jump input
		jump()
	
	var horizontal_direction: float = Input.get_axis("ui_left", "ui_right")
	
	update_horizontal_vel(horizontal_direction)
	
	if horizontal_direction != 0:
		flip_player()
	
	manage_crouching()

func flip_player():
	if velocity.x < 0:
		sprite.scale.x = -1
		player_light_position.scale.x = -1
	else:
		sprite.scale.x = 1
		player_light_position.scale.x = 1

func jump():
	velocity.y -= jump_force

func update_horizontal_vel(horizontal_direction):
	velocity.x = speed * horizontal_direction

func manage_crouching():
	if Input.is_action_pressed("ui_down") and is_on_floor():
		if velocity.x == 0:
			is_ducking = true
		else:
			velocity.x = 0
			is_ducking = true
	else:
		is_ducking = false

func update_movement_animation(velocity):
	if is_on_floor():
		if velocity.x == 0:
			if is_ducking:
				ap.play("duck")
			else:
				ap.play("idle")
		else:
			ap.play("run")
	else:
		if velocity.y < 0:
			ap.play("jump")
		elif velocity.y > 0:
			ap.play("fall")
