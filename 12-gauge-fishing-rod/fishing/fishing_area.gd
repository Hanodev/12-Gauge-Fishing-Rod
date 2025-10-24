class_name FishingArea
extends Area3D
const TEST_FISH = preload("uid://bodorvbtoxett")

func get_fished(fish_point: Vector3, rod_position: Vector3) -> void:
	var fish: RigidBody3D = TEST_FISH.instantiate()
	get_tree().current_scene.add_child(fish)
	fish.global_position = fish_point
	var direction = fish_point.direction_to(rod_position) * 15.0
	fish.apply_central_impulse(direction + (Vector3.UP * 15.0))
