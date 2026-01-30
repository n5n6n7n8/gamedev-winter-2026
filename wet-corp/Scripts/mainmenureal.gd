extends Control


# Called when the node enters the scene tree for the first time.


func _on_btn_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")


func _on_btn_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits.tscn")


func _on_btn_quit_pressed() -> void:
	get_tree().quit()
