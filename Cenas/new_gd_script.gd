extends Enemy

class_name Moto

func _die():
	super._die()
	set_collision_layer_value(3, false)
	set_collision_layer_value(1, false)
	get_tree().create_timer(0.5).timeout.connect(queue_free)

func _on_area_entered(area: Area2D) -> void:
	if area is Moto:
		_die_from_hit()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
