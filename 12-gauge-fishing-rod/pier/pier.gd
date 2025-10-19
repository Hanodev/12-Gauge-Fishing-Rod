extends Node3D


func _on_interactable_interacted() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
