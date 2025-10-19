@icon("res://visuals/icons/usable.svg")
class_name Interactable
extends Area3D

signal interacted()
signal hovered()
signal unhovered()

@export var auto_configure:= true ## Configures it's Layer Masks
@export var single_interaction_only:= false ## If True, only works Once

func _ready() -> void:
	if auto_configure:
		set_collision_layer_value(6,true)
		set_collision_mask_value(1,false)

func interact():
	interacted.emit()
	if single_interaction_only:
		set_block_signals(true)

func uninteract():
	pass

func hover():
	hovered.emit()

func unhover():
	unhovered.emit()
