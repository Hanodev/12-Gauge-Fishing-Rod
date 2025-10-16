class_name Equipment
extends Node3D

signal primary_activated()
signal secondary_activated()
signal special_activated()

enum ACTION {PRIMARY, SECONDARY, SPECIAL}

func activate_equipment(action:= ACTION.PRIMARY, activated:= false) -> void:
	pass
