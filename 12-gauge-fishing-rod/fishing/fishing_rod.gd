extends RayCast3D

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed(&"Primary"):
		if is_colliding():
			var col = get_collider()
			if col is FishingArea:
				col.get_fished(get_collision_point(),global_position)
				print('poo')
