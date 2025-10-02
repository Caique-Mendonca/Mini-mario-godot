extends Enemy
class_name Moto

@export var speed: float = 100
var direction: int = -1 # -1 = esquerda, 1 = direita
var sprite_node: Node = null

func _ready() -> void:
	if has_node("AnimatedSprite2D"):
		sprite_node = $AnimatedSprite2D
	elif has_node("Sprite2D"):
		sprite_node = $Sprite2D
	_update_sprite_direction()

func _physics_process(delta: float) -> void:
		_update_sprite_direction()

func _update_sprite_direction() -> void:
	if sprite_node:
		sprite_node.flip_h = direction < 0

# Se o Player entrar na hitbox da moto → Player morre
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player: 
		(area.get_parent() as Player)._die()

# Caso a moto detecte colisão direta com o corpo do Player
func _on_body_entered(body: Node2D):
	if body is Player:
		(body as Player)._die()
