class_name Gun
extends Equipment

@export var fire_delay: float = 0.0;
@export var target_ray: RayCast3D

@export var projectile_count: int = 1;

var cd: float = 0.0;

func activate_equipment(action:=ACTION.PRIMARY, activated:=false) -> void:
	match action:
		ACTION.PRIMARY: _primary_shot(activated)

func _physics_process(delta: float) -> void:
	if cd > 0.0:
		cd -= delta;
	return;

func _primary_shot(activated:=false) -> void:
	if cd > 0.0:
		return;

	cd = fire_delay;
	primary_activated.emit()
	
	# todo: probably make the ray a component that can do spread and projectile count but whatever
	#for i in projectile_count:
	
	var pos := Manager.get_player_raycast_position();
	var collider := Manager.get_player_raycast_collider();

	if collider.has_method(&"apply_damage"):
		collider.call(&"apply_damage", 100);
	return;

func _secondary_shot(activated:=false) -> void:
	pass

func _special_shot(activated:=false) -> void:
	pass
