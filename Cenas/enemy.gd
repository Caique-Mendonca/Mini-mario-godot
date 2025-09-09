extends Area2D

class_name Enemy

var h_speed = 100
var v_speed = 100
@onready var ray_cast_2d: RayCast2D = $RayCast2D

func _process(delta: float) -> void:
	position.x -= h_speed * delta
	if !ray_cast_2d.is_colliding():
		position.y += h_speed * delta
