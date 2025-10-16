class_name EquipmentHandler
extends Node3D

@export var main_equipment: Equipment

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed(&"Primary"):
		_activate_equipment(0,true)
	if Input.is_action_just_released(&"Primary"):
		_activate_equipment(0,false)

func _activate_equipment(type: int = Equipment.ACTION.PRIMARY, activated:= false) -> void:
	if not main_equipment: return
	main_equipment.activate_equipment(type,activated)
