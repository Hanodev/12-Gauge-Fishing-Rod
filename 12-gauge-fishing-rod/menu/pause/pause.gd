extends MarginContainer

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed(&"Escape"):
		get_tree().paused = !get_tree().paused
		var paused:= get_tree().paused
		visible = paused
		if paused:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
