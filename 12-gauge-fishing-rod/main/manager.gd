extends Node

signal camera_shaked(strength: int)
signal camera_fov_changed(fov: int)

func apply_camera_shake(strength:= 0.6) -> void:
	camera_shaked.emit(strength)
