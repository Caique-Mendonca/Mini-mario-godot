extends Area2D

class_name Enemy

var h_speed = 100
var v_speed = 100
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta: float) -> void:
	position.x -= h_speed * delta
	if !ray_cast_2d.is_colliding():
		position.y += h_speed * delta

func _die():
	h_speed = 0
	v_speed = 0
	animated_sprite_2d.play("death")
	
func _die_from_hit():
	h_speed = 0
	v_speed = 0
	rotation_degrees = 180
	
	set_collision_layer_value(3, false)
	set_collision_layer_value(1, false)
	
	var die_tween = get_tree().create_tween()
	die_tween.tween_property(self, "position", position + Vector2(0, -40), 0.4)
	die_tween.chain().tween_property(self, "position", position + Vector2(0, 300), 2)
