extends Node

signal camera_shaked(strength: int)
signal camera_fov_changed(fov: int)

var player: Player;
var player_vision_cast: RayCast3D;

func apply_camera_shake(strength:=0.6) -> void:
	camera_shaked.emit(strength)

func get_player_raycast_position() -> Vector3:
	var res: Vector3;
	if !player_vision_cast:
		push_error("Player raycast not set");
		return res;

	if player_vision_cast.is_colliding():
		res = player_vision_cast.get_collision_point();
	else:
		res = player_vision_cast.global_position - player_vision_cast.global_basis.z * 300.0;

	return res;

func get_player_raycast_collider() -> Object:
	var res: Object = null;
	if player_vision_cast && player_vision_cast.is_colliding():
		res = player_vision_cast.get_collider();
	return res;