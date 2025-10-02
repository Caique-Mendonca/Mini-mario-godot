extends CharacterBody2D

class_name Player

@export_group("Locomotion")
@export var speed: float = 200
@export var jump_velocity: float = -350

@export_group("Stomping Enemies")
@export var min_stomp_degree: float = 35
@export var max_stomp_degree: float = 145
@export var stomp_y_velocity: float = -150

var is_dead: bool = false
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Pulo (Jump e Space iguais)
	if (Input.is_action_just_pressed("Jump") or Input.is_action_just_pressed("Space")) and is_on_floor():
		velocity.y = jump_velocity
		
	if (Input.is_action_just_released("Jump") or Input.is_action_just_released("Space")) and velocity.y < 0:
		velocity.y *= 0.5
		
	# Movimento horizontal SEM deslizar
	var direction := Input.get_axis("Left", "Right")
	if direction != 0:
		velocity.x = direction * speed
	else:
		velocity.x = 0  # solta a tecla, para na hora
	
	# Chama animação
	$AnimatedSprite2D.trigger_animation(velocity, direction)
	
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if not (area is Enemy) and is_dead:
		return
	
	if area is Koopa and (area as Koopa).in_a_shell:
		(area as Koopa)._on_stomp(global_position)
		return
	
	var angle = rad_to_deg(position.angle_to_point((area as Enemy).position))
	if angle > min_stomp_degree and angle < max_stomp_degree:
		(area as Enemy)._die()
		velocity.y = stomp_y_velocity
	else:
		_die()
		

func _die():
	is_dead = true
	$AnimatedSprite2D.play("small_death")
	set_collision_layer_value(1, false)
	set_collision_layer_value(3, false)
	set_collision_layer_value(4, false)
	set_physics_process(false)
	
	var death_tween = get_tree().create_tween()
	death_tween.tween_property(self, "position", position + Vector2(0, -25), 0.4)
	death_tween.tween_property(self, "position", position + Vector2(0, 250), 1)
	death_tween.tween_callback(func(): get_tree().reload_current_scene())

func _on_area_body_entered(body):
	if body.name == "Moto":
		_die()
