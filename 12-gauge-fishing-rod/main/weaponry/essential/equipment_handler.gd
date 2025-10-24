class_name EquipmentHandler
extends Node3D

@export var equipment: Array[Equipment];

var active_equipment: Equipment;
var active_index: int = -1;

func _ready() -> void:
	if equipment.is_empty():
		return;

	_change_active_equipment(0);
	return;

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed(&"Primary"):
		_activate_equipment(0, true)

func _activate_equipment(type: int = Equipment.ACTION.PRIMARY, activated:=false) -> void:
	if active_equipment:
		active_equipment.activate_equipment(type, activated);

func _change_active_equipment(index: int) -> void:
	if equipment.size() < index:
		return;

	active_index = index;
	var next := equipment[index];
	if next == active_equipment:
		return;

	# do weapon swap animations here etc after we determine shit has actually changed
	active_equipment = equipment[index];
	return;
