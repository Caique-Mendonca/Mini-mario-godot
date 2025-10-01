extends CharacterBody2D
class_name Moto

@export var speed: float = 100
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: int = -1 # -1 = esquerda, 1 = direita
var sprite_node: Node = null

func _ready() -> void:
	if has_node("AnimatedSprite2D"):
		sprite_node = $AnimatedSprite2D
	elif has_node("Sprite2D"):
		sprite_node = $Sprite2D
	_update_sprite_direction()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	velocity.x = direction * speed
	move_and_slide()

	if is_on_wall():
		direction *= -1
		_update_sprite_direction()


func _update_sprite_direction() -> void:
	if sprite_node:
		sprite_node.flip_h = direction < 0

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player: 
		(area.get_parent() as Player)._die()


func _on_area_2d_area_entered(area: Area2D) -> void:
	_die() # Replace with function body.
