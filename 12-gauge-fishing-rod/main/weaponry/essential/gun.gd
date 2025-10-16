class_name Gun
extends Equipment


@export var target_ray: RayCast3D

func activate_equipment(action:= ACTION.PRIMARY, activated:= false) -> void:
	match action:
		ACTION.PRIMARY: _primary_shot(activated)

func _primary_shot(activated:= false) -> void:
	primary_activated.emit()
	if target_ray:
		pass

func _secondary_shot(activated:= false) -> void:
	pass

func _special_shot(activated:= false) -> void:
	pass
