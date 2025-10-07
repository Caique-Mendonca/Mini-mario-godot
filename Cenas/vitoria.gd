extends Control

func _on_jogar_novamente_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/main.tscn") # Replace with function body.


func _on_sair_pressed() -> void:
	get_tree().quit() # Replace with function body.
